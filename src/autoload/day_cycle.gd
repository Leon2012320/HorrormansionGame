extends Node
## Der Tagesablauf: Morgen → Tag → Nacht → Night Report.
##
## Hier läuft die Schlaf-Sequenz, in der 90 % aller Ereignisse passieren.

signal phase_changed(phase: int)
signal night_started(segments: int)
signal wake_event(event: Dictionary, segment: int)
signal night_finished(report: Array)
signal day_started(day: int, energy: int)

enum Phase { MORNING, DAY, NIGHT, REPORT, ENDED }

var phase: int = Phase.DAY
var last_report: Array[String] = []
var had_hot_meal := false

var _pending_segments := 0
## Zwei Zähler, die auseinandergehalten werden müssen:
## _segments_done  — wie weit die Nacht ist. Steigt IMMER, sonst endet sie nie.
## _segments_counted — wie viele Segmente für ENERGY zählen. Ein verfallenes
##                     Segment bringt die Nacht voran, aber keine Erholung.
var _segments_done := 0
var _segments_counted := 0
var _current_room := ""
var _night_log: Array[String] = []
var _awaiting_choice := false


func start_run() -> void:
	GameState.reset_run()
	Rooms.reset()
	Inventory.reset()
	Notebook.reset()
	Garden.reset()
	EventDeck.reset()
	had_hot_meal = false
	phase = Phase.DAY
	GameState.set_energy(6)
	day_started.emit(GameState.day, GameState.energy)
	phase_changed.emit(phase)


## Startet die Nacht. Gibt false zurück, wenn gerade nicht geschlafen werden kann.
func sleep(segments: int) -> bool:
	if phase != Phase.DAY or not GameState.run_active:
		return false
	segments = clampi(segments, 1, 3)
	if GameState.has_condition("shaken"):
		segments = 1  # Shaken: nur ein Segment möglich.
	_pending_segments = segments
	_segments_done = 0
	_segments_counted = 0
	_awaiting_choice = false
	_current_room = Rooms.current_id
	_night_log.clear()
	phase = Phase.NIGHT
	phase_changed.emit(phase)
	EventDeck.begin_night()
	night_started.emit(segments)
	_run_segments()
	return true


## Arbeitet die Segmente ab. Bricht ab, sobald ein Wake-Ereignis eine
## Entscheidung verlangt — dann geht es über resolve_choice() weiter.
func _run_segments() -> void:
	while _segments_done < _pending_segments and not _awaiting_choice:
		var event := EventDeck.draw_night_event(_current_room)
		if event.is_empty():
			_segments_done += 1
			_segments_counted += 1
			continue
		var category := str(event.get("category", ""))
		if category in ["wake", "tripline"] and not event.get("options", []).is_empty():
			_awaiting_choice = true
			wake_event.emit(event, _segments_done)
			return
		_night_log.append(str(event.get("text", "")))
		var lines := EventDeck.apply_effects(event.get("effects", {}), _current_room)
		_night_log.append_array(lines)
		_segments_done += 1
		_segments_counted += 1
		if event.get("effects", {}).has("end_night"):
			_pending_segments = _segments_done
			break
	if not _awaiting_choice:
		_finish_night()


## Wird von der UI aufgerufen, wenn der Spieler eine Wake-Option gewählt hat.
func resolve_choice(event: Dictionary, option_index: int, keep_sleeping: bool) -> Array[String]:
	var lines: Array[String] = []
	var options: Array = event.get("options", [])
	if option_index >= 0 and option_index < options.size():
		var option: Dictionary = options[option_index]

		# Materialkosten der Option
		for id in option.get("consumes", {}):
			Inventory.consume(str(id), int(option["consumes"][id]))
		if option.has("needs") and not option.has("consumes"):
			for id in option["needs"]:
				Inventory.consume(str(id), int(option["needs"][id]))

		# Raumwirkungen der Option
		if option.has("sets_safety"):
			Rooms.set_safety(_current_room, int(option["sets_safety"]))
			lines.append("The door will hold for now.")
		if option.has("permanent_safety"):
			Rooms.set_safety(_current_room, Rooms.safety_of(_current_room) + int(option["permanent_safety"]))
			lines.append("That window will not open again.")
		if bool(option.get("places_candle", false)):
			Rooms.place_candle(_current_room, 2)
		if bool(option.get("protects_barricade", false)):
			EventDeck._damage_this_night = true

		lines.append_array(EventDeck.apply_effects(option.get("effects", {}), _current_room))
		if option.has("outcomes"):
			var outcome := EventDeck.roll_outcome(option["outcomes"])
			if outcome.has("text"):
				lines.append(str(outcome["text"]))
			lines.append_array(EventDeck.apply_effects(outcome.get("effects", {}), _current_room))

		# Die Nacht schreitet immer voran. Ob das Segment auch Erholung bringt,
		# entscheidet costs_segment.
		_segments_done += 1
		if not bool(option.get("costs_segment", true)):
			_segments_counted += 1
		if bool(option.get("ends_night", false)):
			_pending_segments = _segments_done
	else:
		_segments_done += 1
	_night_log.append_array(lines)
	_awaiting_choice = false
	if not keep_sleeping:
		_pending_segments = _segments_done
	_run_segments()
	return lines


func _finish_night() -> void:
	if not GameState.run_active:
		phase = Phase.ENDED
		phase_changed.emit(phase)
		return

	# Zwei kurze Nächte hintereinander machen erschöpft.
	if _segments_counted <= 1:
		GameState.short_sleep_streak += 1
		if GameState.short_sleep_streak >= 2:
			GameState.add_condition("exhausted")
	else:
		GameState.short_sleep_streak = 0
		if _segments_counted >= 3:
			GameState.remove_condition("exhausted")

	var in_bed := bool(Rooms.def(_current_room).get("has_bed", false)) or Inventory.has("blanket")
	var messages := GameState.begin_new_day()
	_night_log.append_array(messages)

	Rooms.advance_day()
	_night_log.append_array(Garden.advance_day())
	EventDeck.begin_day()
	if not Inventory.consume_daily_power():
		_night_log.append("The flashlight is dead.")

	if not GameState.run_active:
		phase = Phase.ENDED
		last_report = _night_log.duplicate()
		night_finished.emit(last_report)
		phase_changed.emit(phase)
		return

	GameState.set_energy(GameState.compute_energy(_segments_counted, in_bed, had_hot_meal))
	had_hot_meal = false

	if _night_log.is_empty():
		_night_log.append("You slept. Nothing happened.")

	last_report = _night_log.duplicate()
	phase = Phase.REPORT
	phase_changed.emit(phase)
	night_finished.emit(last_report)


## Vom Night Report aus: zurück in den Tag.
func begin_day() -> void:
	phase = Phase.DAY
	phase_changed.emit(phase)
	day_started.emit(GameState.day, GameState.energy)

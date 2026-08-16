extends Control
## Verdrahtet Raumansicht, HUD und Dialoge mit den Autoloads.
##
## Hier stehen die Aktionstypen — jeder Hotspot in content/rooms_db.gd
## verweist über "type" auf einen Fall in _perform().

const ItemsDB := preload("res://content/items_db.gd")
const EventsDB := preload("res://content/events_db.gd")

var room_view: RoomView
var hud: AshHud
var dialog: AshDialog
var log_label: Label

var _pending_wake: Dictionary = {}
var _pending_hotspot: Dictionary = {}
var _log_lines: Array[String] = []


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	var bg := ColorRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.color = AshTheme.INK
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)

	room_view = RoomView.new()
	add_child(room_view)
	room_view.hotspot_pressed.connect(_on_hotspot)
	room_view.exit_pressed.connect(_on_exit)

	hud = AshHud.new()
	add_child(hud)

	log_label = Label.new()
	log_label.position = Vector2(8, 268)
	log_label.size = Vector2(624, 24)
	log_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	AshTheme.apply_label(log_label, true)
	log_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(log_label)

	_build_toolbar()

	dialog = AshDialog.new()
	dialog.position = Vector2(110, 60)
	dialog.visible = false
	add_child(dialog)
	dialog.choice_made.connect(_on_dialog_choice)

	DayCycle.wake_event.connect(_on_wake_event)
	DayCycle.night_finished.connect(_on_night_finished)
	GameState.run_ended.connect(_on_run_ended)
	Inventory.item_found.connect(func(id, n): _log("Found %s ×%d." % [Inventory.display_name(id), n]))
	Rooms.restocked_found.connect(func(_r, _h): _log("You emptied this one days ago. There is something in it again."))

	DayCycle.start_run()
	room_view.refresh()
	_log("The door will not open. It is getting dark.")


func _build_toolbar() -> void:
	var bar := HBoxContainer.new()
	bar.position = Vector2(430, 322)
	bar.add_theme_constant_override("separation", 4)
	add_child(bar)
	for entry in [["Sleep", _open_sleep], ["Notebook", _open_notebook],
			["Torch", _toggle_light], ["Candle", _light_candle]]:
		var button := Button.new()
		button.text = str(entry[0])
		AshTheme.apply_button(button)
		button.pressed.connect(entry[1])
		bar.add_child(button)


## --- Eingaben ----------------------------------------------------------------

func _on_exit(room_id: String) -> void:
	if not Rooms.travel_to(room_id):
		return
	room_view.refresh()
	var event := EventDeck.draw_day_event()
	if not event.is_empty():
		_log(str(event.get("text", "")))
		EventDeck.apply_effects(event.get("effects", {}), Rooms.current_id)


func _on_hotspot(spot: Dictionary) -> void:
	_pending_hotspot = spot
	var options: Array = []
	for action in spot.get("actions", []):
		var cost := int(action.get("cost", 1))
		var hint := "%d action%s" % [cost, "" if cost == 1 else "s"] if cost > 0 else "free"
		options.append({
			"label": str(action.get("label", "…")),
			"hint": hint,
			"enabled": GameState.can_spend(cost),
		})
	options.append({"label": "Look at it", "hint": "free", "enabled": true})
	options.append({"label": "Step back", "hint": "", "enabled": true})
	dialog.show_dialog(str(spot.get("name", "")), str(spot.get("look", "")), options)


func _on_dialog_choice(index: int) -> void:
	if not _pending_wake.is_empty():
		_resolve_wake(index)
		return
	if _pending_hotspot.is_empty():
		dialog.close()
		return
	var actions: Array = _pending_hotspot.get("actions", [])
	if index < actions.size():
		dialog.close()
		_perform(actions[index], _pending_hotspot)
	elif index == actions.size():
		_log(str(_pending_hotspot.get("look", "")))
		dialog.close()
	else:
		dialog.close()
	_pending_hotspot = {}


## --- Aktionen ----------------------------------------------------------------

func _perform(action: Dictionary, spot: Dictionary) -> void:
	var cost := int(action.get("cost", 1))
	if cost > 0 and not GameState.spend_action(cost):
		_log("You are too tired to do that today.")
		return

	match str(action.get("type", "")):
		"search":
			_do_search(action, spot)
		"cook":
			_do_cook()
		"radio":
			_do_radio()
		"telephone":
			_do_telephone()
		"fuse_box":
			_do_fuse_box()
		"dismantle":
			var boards := int(action.get("boards", 2))
			Inventory.add_carried("board", boards)
			_log("You break it up. %d boards." % boards)
		"plant":
			_do_plant()
		"water":
			_do_water()
		"harvest":
			_do_harvest()
		"front_door":
			_do_front_door()
		"window":
			_do_window()
		_:
			_log("Nothing happens.")
	room_view.refresh()
	hud.refresh()


func _do_search(action: Dictionary, spot: Dictionary) -> void:
	var spot_id := str(spot.get("id", ""))
	if Rooms.is_searched(Rooms.current_id, spot_id):
		_log("You have been through this already.")
		return
	if Rooms.search_hotspot(Rooms.current_id, spot_id, action).is_empty():
		_log("Nothing you can use.")


func _do_cook() -> void:
	if Rooms.light_of("kitchen") < Rooms.Light.ELECTRIC:
		_log("The stove has no power. There is a fuse box in the cellar.")
		return
	for id in ["can_soup", "can_beans", "can_meat", "catch_raw", "crop_ripe"]:
		if Inventory.has(id):
			Inventory.consume(id, 1)
			GameState.add_food(55)
			DayCycle.had_hot_meal = true
			_log("A hot meal. The first one in a while.")
			return
	_log("Nothing to cook.")


func _do_radio() -> void:
	var line := ""
	for entry in EventsDB.RADIO:
		if GameState.day >= int(entry["from_day"]):
			line = str(entry["text"])
	if line == "":
		line = "Static, all the way across the dial."
	# Ab Tag 12 liest es manchmal Namen vor. Ob einer deiner ist, wird nie geklärt.
	if GameState.day >= 12 and randf() < 0.2:
		Notebook.add_fragment()
		GameState.add_condition("shaken")
		_show_note("The Radio", "A list of names, read out slowly, with pauses. You write one of them down.")
		return
	_show_note("The Radio", line)


func _do_telephone() -> void:
	var roll := randf()
	if roll < 0.35:
		Notebook.add_fragment()
		_show_note("The Telephone", "Someone is already talking when you pick up. You write down what they say before you think about it.")
	elif roll < 0.70:
		GameState.add_condition("shaken")
		_show_note("The Telephone", "Silence, and then breathing, patient and close.")
	else:
		_show_note("The Telephone", "A dial tone. The line was cut before you got here. You checked.")


func _do_fuse_box() -> void:
	var options: Array = []
	var targets: Array = []
	for id in Rooms.state:
		if not Rooms.is_available(str(id)):
			continue
		var has_fuse := bool(Rooms.state[id].get("has_fuse", false))
		options.append({
			"label": ("REMOVE  " if has_fuse else "POWER   ") + Rooms.display_name(str(id)),
			"hint": "", "enabled": true})
		targets.append(str(id))
	options.append({"label": "Leave it", "hint": "", "enabled": true})
	_pending_hotspot = {"fuse_targets": targets, "actions": []}
	dialog.show_dialog("Fuse Box",
		"Three fuses. %d in use." % _fuses_in_use(), options)
	if dialog.choice_made.is_connected(_on_dialog_choice):
		dialog.choice_made.disconnect(_on_dialog_choice)
	dialog.choice_made.connect(_on_fuse_choice, CONNECT_ONE_SHOT)


func _on_fuse_choice(index: int) -> void:
	var targets: Array = _pending_hotspot.get("fuse_targets", [])
	dialog.close()
	dialog.choice_made.connect(_on_dialog_choice)
	_pending_hotspot = {}
	if index >= targets.size():
		return
	var id := str(targets[index])
	if bool(Rooms.state[id].get("has_fuse", false)):
		Rooms.set_fuse(id, false)
		_log("You take the fuse out of %s." % Rooms.display_name(id))
	elif _fuses_in_use() >= 3:
		_log("All three fuses are in use. Take one out first.")
	else:
		Rooms.set_fuse(id, true)
		_log("%s has light." % Rooms.display_name(id))
	room_view.refresh()
	hud.refresh()


func _fuses_in_use() -> int:
	var count := 0
	for id in Rooms.state:
		if bool(Rooms.state[id].get("has_fuse", false)):
			count += 1
	return count


## --- Anbau -----------------------------------------------------------------
## Die Logik liegt in src/autoload/garden.gd, damit der Smoke-Test sie teilt.

func _do_plant() -> void:
	_log(Garden.plant())


func _do_water() -> void:
	_log(Garden.water())


func _do_harvest() -> void:
	_log(Garden.harvest())


## --- Enden -------------------------------------------------------------------

func _do_front_door() -> void:
	var result := Notebook.attempt_door()
	match result:
		"TOO_EARLY":
			_show_note("The Front Door", "It does not move. You do not know enough about this house yet.")
		"INCOMPLETE":
			_show_note("The Front Door", "You have questions in the notebook you cannot answer. The handle does not turn.")
		"THE_DOOR":
			GameState.end_run("THE_DOOR", "You went out through the front door.")
		"THE_THRESHOLD":
			GameState.end_run("THE_THRESHOLD", "The door opened. It did not close behind you.")
		_:
			for i in Notebook.answers.size():
				Notebook.answers[i] = ""
			GameState.begin_new_day()
			_show_note("The Front Door", "Nothing. What you brought is gone, and so is the day.")


func _do_window() -> void:
	GameState.end_run("THE_WINDOW", "You broke the glass and went out into the garden.")


## --- Schlaf ------------------------------------------------------------------

func _open_sleep() -> void:
	var id := Rooms.current_id
	var body := "%s\n\n%s" % [Rooms.display_name(id), Rooms.sleep_assessment(id)]
	var shaken := GameState.has_condition("shaken")
	dialog.show_dialog("Sleep", body, [
		{"label": "One segment", "hint": "energy 2", "enabled": true},
		{"label": "Two segments", "hint": "energy 4", "enabled": not shaken},
		{"label": "The whole night", "hint": "energy 6", "enabled": not shaken},
		{"label": "Not yet", "hint": "", "enabled": true},
	])
	if dialog.choice_made.is_connected(_on_dialog_choice):
		dialog.choice_made.disconnect(_on_dialog_choice)
	dialog.choice_made.connect(_on_sleep_choice, CONNECT_ONE_SHOT)


func _on_sleep_choice(index: int) -> void:
	dialog.close()
	dialog.choice_made.connect(_on_dialog_choice)
	if index >= 3:
		return
	DayCycle.sleep(index + 1)


func _on_wake_event(event: Dictionary, _segment: int) -> void:
	_pending_wake = event
	var options: Array = []
	for option in event.get("options", []):
		var enabled := true
		var hint := ""
		for id in option.get("needs", {}):
			var amount := int(option["needs"][id])
			if not Inventory.has(str(id), amount):
				enabled = false
			hint += "%s ×%d " % [Inventory.display_name(str(id)), amount]
		if bool(option.get("costs_segment", true)):
			hint += "· costs the rest of this segment"
		options.append({"label": str(option.get("label", "…")), "hint": hint.strip_edges(), "enabled": enabled})
	dialog.show_dialog(str(event.get("title", "You wake up")), str(event.get("text", "")), options)


func _resolve_wake(index: int) -> void:
	var event := _pending_wake
	_pending_wake = {}
	dialog.close()
	var lines := DayCycle.resolve_choice(event, index, true)
	for line in lines:
		_log(line)


func _on_night_finished(report: Array) -> void:
	var body := ""
	for line in report:
		if str(line) != "":
			body += "— " + str(line) + "\n"
	if body == "":
		body = "— You slept. Nothing happened.\n"
	body += "\nENERGY today: %d" % GameState.energy
	dialog.show_dialog("Day %d" % GameState.day, body,
		[{"label": "Get up", "hint": "", "enabled": true}])
	if dialog.choice_made.is_connected(_on_dialog_choice):
		dialog.choice_made.disconnect(_on_dialog_choice)
	dialog.choice_made.connect(_on_report_dismissed, CONNECT_ONE_SHOT)


func _on_report_dismissed(_index: int) -> void:
	dialog.close()
	dialog.choice_made.connect(_on_dialog_choice)
	DayCycle.begin_day()
	room_view.refresh()
	hud.refresh()


## --- Sonstiges ---------------------------------------------------------------

func _open_notebook() -> void:
	var body := ""
	for i in Notebook.QUESTIONS.size():
		var answer: String = str(Notebook.answers[i])
		body += "%d. %s\n   %s\n" % [
			i + 1, Notebook.QUESTIONS[i],
			answer if answer != "" else "fragments: %d of %d" % [Notebook.fragments[i], Notebook.FRAGMENTS_PER_QUESTION]]
	dialog.show_dialog("Notebook", body, [{"label": "Close", "hint": "", "enabled": true}])


func _toggle_light() -> void:
	if Inventory.toggle_flashlight():
		_log("The flashlight works. One battery a day.")
	else:
		_log("Off." if not Inventory.flashlight_on else "No batteries.")
	room_view.refresh()
	hud.refresh()


func _light_candle() -> void:
	_log(Rooms.light_candle(Rooms.current_id))
	room_view.refresh()
	hud.refresh()


func _show_note(title: String, body: String) -> void:
	dialog.show_dialog(title, body, [{"label": "Close", "hint": "", "enabled": true}])


func _on_run_ended(result: String, detail: String) -> void:
	var body := detail + "\n\nDay %d.\nFragments found: %d of 12." % [GameState.day, Notebook.total_fragments()]
	body += "\n\nThere is no saved game. There never was."
	dialog.show_dialog(result.replace("_", " "), body,
		[{"label": "Start again", "hint": "", "enabled": true}])
	if dialog.choice_made.is_connected(_on_dialog_choice):
		dialog.choice_made.disconnect(_on_dialog_choice)
	dialog.choice_made.connect(func(_i):
		dialog.close()
		dialog.choice_made.connect(_on_dialog_choice)
		DayCycle.start_run()
		room_view.refresh()
		hud.refresh()
		_log("The door will not open. It is getting dark."), CONNECT_ONE_SHOT)


func _log(line: String) -> void:
	if line == "":
		return
	_log_lines.append(line)
	while _log_lines.size() > 2:
		_log_lines.pop_front()
	log_label.text = "\n".join(_log_lines)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_sleep"):
		_open_sleep()
	elif event.is_action_pressed("toggle_light"):
		_toggle_light()

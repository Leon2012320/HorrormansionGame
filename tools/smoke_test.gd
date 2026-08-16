extends Node
## Spielt komplette Durchläufe headless durch, ohne Oberfläche.
##
##     godot --headless res://tools/smoke_test.tscn
##
## Findet Abstürze, tote Schleifen und grobe Balancing-Fehler, bevor man
## das Spiel von Hand startet. Der Bot spielt bewusst mittelmäßig:
## er sucht, baut gelegentlich und schläft, wenn die Energie leer ist.

const RUNS := 40

var _endings := {}
var _days: Array[int] = []
var _errors: Array[String] = []
var _solved := 0
var _specials_found := 0
var _unsolved := 0


func _ready() -> void:
	for i in RUNS:
		seed(i * 7919)
		_play_one_run(i)
	_report()
	get_tree().quit(1 if not _errors.is_empty() else 0)


func _play_one_run(index: int) -> void:
	DayCycle.start_run()
	if not DayCycle.problem_event.is_connected(_auto_answer):
		DayCycle.problem_event.connect(_auto_answer)
	if not Specials.special_found.is_connected(_note_special):
		Specials.special_found.connect(_note_special)

	var guard := 0
	while GameState.run_active and guard < 400:
		guard += 1
		# Tagsüber Handlungen ausgeben, bis die Energie leer ist.
		# Essen ist kostenlos, muss also außerhalb stehen — sonst dreht sich
		# die Schleife, ohne Energie zu verbrauchen.
		var day_guard := 0
		while GameState.energy > 0 and GameState.run_active and day_guard < 20:
			day_guard += 1
			_eat_if_hungry()
			_treat_if_hurt()
			if not _take_one_action():
				break
		if not GameState.run_active:
			break
		# Zum Schlafen ins Bett — Laufen kostet nichts.
		_goto("bedroom")
		_pack_for_the_night()
		# Länge zufällig, damit auch kurze Nächte vorkommen.
		var segments := 3 if randf() < 0.7 else randi_range(1, 2)
		if not DayCycle.sleep(segments):
			_errors.append("Run %d: could not sleep on day %d" % [index, GameState.day])
			break
		if DayCycle.phase == DayCycle.Phase.REPORT:
			DayCycle.begin_day()
		_check_invariants(index)

	if guard >= 400:
		_errors.append("Run %d: did not terminate" % index)

	var ending := GameState.ending if GameState.ending != "" else "UNFINISHED"
	var key := "%s — %s" % [ending, GameState.ending_detail] if GameState.ending_detail != "" else ending
	_endings[key] = int(_endings.get(key, 0)) + 1
	_days.append(GameState.day)
	DayCycle.problem_event.disconnect(_auto_answer)


func _note_special(_id: String) -> void:
	_specials_found += 1


func _eat_if_hungry() -> void:
	if GameState.food >= 45:
		return
	for id in ["can_beans", "can_meat", "can_soup", "preserves", "crop_ripe", "bread"]:
		if Inventory.has(id):
			Inventory.eat(id)
			return


func _treat_if_hurt() -> void:
	for id in GameState.conditions.keys():
		Inventory.treat(str(id))


## Laufen ist kostenlos, der Bot darf also direkt umsetzen.
func _goto(room_id: String) -> void:
	if Rooms.is_available(room_id):
		Rooms.current_id = room_id


## Gibt false zurück, wenn keine Handlung mehr möglich war — dann endet der Tag.
func _take_one_action() -> bool:
	# Den Schlafplatz sichern, sobald Material da ist. Die SAFETY-Achse ist
	# sonst tot — der Bot schlief zwanzig Nächte bei offener Tür.
	if Rooms.safety_of("bedroom") < Rooms.Safety.BARRICADED:
		_goto("bedroom")
		if Rooms.can_fortify("bedroom", Rooms.Safety.BARRICADED):
			Rooms.fortify("bedroom", Rooms.Safety.BARRICADED)
			return true
		if Rooms.can_fortify("bedroom", Rooms.Safety.BLOCKED):
			Rooms.fortify("bedroom", Rooms.Safety.BLOCKED)
			return true
		Rooms.fortify("bedroom", Rooms.Safety.CLOSED)   # kostenlos

	# Eine Falle stellen, solange Platz ist.
	if Crafting.traps.size() < Crafting.MAX_TRAPS and Inventory.has("wire") and Inventory.has("board"):
		_goto("cellar")
		if Crafting.can_build("snare"):
			Crafting.build("snare")
			return true

	# Fallen leeren ist kostenlos.
	for room_id in Crafting.traps.keys():
		if Crafting.trap_ready(str(room_id)):
			Crafting.collect_trap(str(room_id))

	# Sobald alle vier Fragen beantwortbar sind: antworten und zur Tür gehen.
	if _try_the_door():
		return true

	# Der Garten hat Vorrang: er ist die einzige Quelle, die nachwächst.
	if Garden.has_ripe():
		_goto(Garden.ROOM)
		if not GameState.spend_action(1):
			return false
		Garden.harvest()
		return true
	if Garden.needs_water():
		_goto(Garden.ROOM)
		if not GameState.spend_action(1):
			return false
		Garden.water()
		return true
	if Garden.free_beds() > 0 and Inventory.has("seeds"):
		_goto(Garden.ROOM)
		if not GameState.spend_action(1):
			return false
		Garden.plant()
		return true

	# Einen Raum suchen, in dem noch etwas zu holen ist, und hingehen.
	# Laufen ist kostenlos, das darf also im selben Zug passieren.
	var target := Rooms.current_id
	if not Rooms.has_unsearched(target):
		for candidate in Rooms.state.keys():
			if Rooms.is_available(str(candidate)) and Rooms.has_unsearched(str(candidate)):
				target = str(candidate)
				break
	_goto(target)

	# Licht machen, bevor gesucht wird — im Dunkeln findet man weniger.
	if Rooms.light_of(target) <= Rooms.Light.DARK and Rooms.has_unsearched(target):
		if Inventory.has("battery") and not Inventory.flashlight_on:
			Inventory.toggle_flashlight()
		elif Inventory.has("candle") and (Inventory.has("matches") or Inventory.match_uses > 0):
			Rooms.light_candle(target)

	for spot in Rooms.hotspots(target):
		if Rooms.is_searched(target, str(spot.get("id", ""))):
			continue
		for action in spot.get("actions", []):
			if str(action.get("type", "")) != "search":
				continue
			if not GameState.spend_action(int(action.get("cost", 1))):
				return false
			Rooms.search_hotspot(target, str(spot["id"]), action)
			return true

	# Nichts mehr zu tun: der Tag verfällt.
	return GameState.spend_action(1)


## Die eigentliche Entscheidung des Spiels: was kommt in die sechs Plätze?
## Der Bot packt nach fester Prioritätenliste — ein Mensch würde je nach
## Lage anders wählen, aber so ist der Test wenigstens vergleichbar.
const NIGHT_KIT := ["hammer", "board", "candle", "matches", "bandage", "crowbar"]

func _pack_for_the_night() -> void:
	# Erst alles ablegen, was heute Nacht nichts nützt.
	for id in Inventory.carried.keys():
		if not str(id) in NIGHT_KIT:
			Inventory.put_in_stash(str(id), int(Inventory.carried[id]))
	# Dann die Packliste auffüllen, solange Platz ist.
	for id in NIGHT_KIT:
		while Inventory.take_from_stash(id, 1):
			if Inventory.carried_count(id) >= 2:
				break


## Der Bot benutzt die erste Lösung, die er dabei hat — oder gar keine.
## Der Bot rät die Antworten — er kennt die Lösung so wenig wie ein Spieler
## beim ersten Durchlauf. Damit misst der Test auch, wie oft THE_DOOR fällt.
func _try_the_door() -> bool:
	if not GameState.mystery_unlocked():
		return false
	for i in Notebook.QUESTIONS.size():
		if str(Notebook.answers[i]) != "":
			continue
		if not Notebook.can_answer(i):
			return false
		# Fragmente haben falsche Antworten gestrichen — der Bot wählt aus dem Rest.
		var left := Notebook.remaining_answers(i)
		Notebook.set_answer(i, left[randi() % left.size()] if not left.is_empty() else 0)
	if not Notebook.all_answered():
		return false
	_goto("entrance")
	match Notebook.attempt_door():
		"THE_DOOR":
			GameState.end_run("THE_DOOR", "You went out through the front door.")
		"THE_THRESHOLD":
			GameState.end_run("THE_THRESHOLD", "The door opened. It did not close behind you.")
		_:
			for i in Notebook.answers.size():
				Notebook.answers[i] = ""
			GameState.begin_new_day()
	return true


func _auto_answer(event: Dictionary, solutions: Array) -> void:
	if solutions.is_empty():
		_unsolved += 1
		DayCycle.solve(event, -1)
	else:
		_solved += 1
		DayCycle.solve(event, int(solutions[0]["index"]))


func _check_invariants(index: int) -> void:
	if GameState.energy < 0:
		_errors.append("Run %d day %d: negative energy" % [index, GameState.day])
	if GameState.energy_max > GameState.ENERGY_MAX:
		_errors.append("Run %d day %d: energy above cap (%d)" % [index, GameState.day, GameState.energy_max])
	if GameState.food < 0 or GameState.food > GameState.FOOD_MAX:
		_errors.append("Run %d day %d: food out of range (%d)" % [index, GameState.day, GameState.food])
	if Inventory.slots_used() > Inventory.CARRY_SLOTS:
		_errors.append("Run %d day %d: carrying %d slots" % [index, GameState.day, Inventory.slots_used()])
	if Notebook.total_fragments() > 12:
		_errors.append("Run %d day %d: too many fragments" % [index, GameState.day])


func _report() -> void:
	var total := 0
	for d in _days:
		total += d
	print("")
	print("=== ASHGROVE SMOKE TEST · %d runs ===" % RUNS)
	print("average length: %.1f days" % (float(total) / float(maxi(_days.size(), 1))))
	print("shortest / longest: %d / %d" % [_days.min(), _days.max()])
	print("endings:")
	for key in _endings:
		print("   %-40s %d" % [key, _endings[key]])
	print("special items found: %d over %d runs (%.1f per run)" % [
		_specials_found, RUNS, float(_specials_found) / float(RUNS)])
	print("problems solved with an item: %d of %d (%d%%)" % [
		_solved, _solved + _unsolved,
		int(round(100.0 * float(_solved) / float(maxi(_solved + _unsolved, 1))))])
	if _errors.is_empty():
		print("no errors")
	else:
		print("ERRORS (%d):" % _errors.size())
		for line in _errors.slice(0, 15):
			print("   " + line)
	print("")

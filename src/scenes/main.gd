extends Control
## Verdrahtet Raumansicht, HUD und Dialoge mit den Autoloads.
##
## Alle Menüs laufen über _open_menu(): Einträge bringen ihre eigene Callable
## mit, statt dass der Dialog für jeden Fall neu verkabelt wird.
## Spiellogik steht bewusst NICHT hier, sondern in den Autoloads — sonst kann
## der Smoke-Test sie nicht prüfen.

const EventsDB := preload("res://content/events_db.gd")

var room_view: RoomView
var hud: AshHud
var dialog: AshDialog
var log_label: Label

var _entries: Array = []            ## aktuelle Menüeinträge mit ihren Callables
var _pending_problem: Dictionary = {}
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
	log_label.position = Vector2(8, 262)
	log_label.size = Vector2(624, 30)
	log_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	AshTheme.apply_label(log_label, true)
	log_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(log_label)

	_build_toolbar()

	dialog = AshDialog.new()
	dialog.position = Vector2(105, 50)
	dialog.visible = false
	add_child(dialog)
	dialog.choice_made.connect(_on_menu_choice)

	DayCycle.problem_event.connect(_on_problem_event)
	DayCycle.night_finished.connect(_on_night_finished)
	GameState.run_ended.connect(_on_run_ended)
	Inventory.item_found.connect(func(id, n): _log("Found %s ×%d." % [Inventory.display_name(id), n]))
	Rooms.restocked_found.connect(func(_r, _h):
		_log("You emptied this one days ago. There is something in it again."))
	Notebook.answer_excluded.connect(func(_q, answer):
		_log("Whatever it is, it is not %s." % str(answer).to_lower()))
	Specials.special_found.connect(func(id):
		_note(Specials.display_name(id), str(Specials.spec(id).get("found", ""))))

	DayCycle.start_run()
	room_view.refresh()
	_log("The door will not open. It is getting dark.")


func _build_toolbar() -> void:
	var bar := HBoxContainer.new()
	bar.position = Vector2(8, 322)
	bar.add_theme_constant_override("separation", 3)
	add_child(bar)
	for entry in [
		["Sleep", _open_sleep], ["Bag", _open_bag], ["Door", _open_door],
		["Build", _open_build], ["Notebook", _open_notebook], ["Map", _open_map],
		["Torch", _toggle_light],
	]:
		var button := Button.new()
		button.text = str(entry[0])
		AshTheme.apply_button(button)
		button.pressed.connect(entry[1])
		bar.add_child(button)


## --- Menü-Grundlage ----------------------------------------------------------

## entries: Array von {label, hint, enabled, action: Callable}
func _open_menu(title: String, body: String, entries: Array) -> void:
	_entries = entries
	var options: Array = []
	for entry in entries:
		options.append({
			"label": str(entry.get("label", "…")),
			"hint": str(entry.get("hint", "")),
			"enabled": bool(entry.get("enabled", true)),
		})
	dialog.show_dialog(title, body, options)


func _on_menu_choice(index: int) -> void:
	if not _pending_problem.is_empty():
		_resolve_problem(index)
		return
	if index < 0 or index >= _entries.size():
		dialog.close()
		return
	var entry: Dictionary = _entries[index]
	dialog.close()
	if entry.has("action"):
		(entry["action"] as Callable).call()
	_refresh()


func _close_entry() -> Dictionary:
	return {"label": "Close", "hint": "", "enabled": true, "action": func(): pass}


func _refresh() -> void:
	room_view.refresh()
	hud.refresh()


## --- Raum und Hotspots -------------------------------------------------------

func _on_exit(room_id: String) -> void:
	if not Rooms.travel_to(room_id):
		return
	_refresh()
	var event := EventDeck.draw_day_event()
	if not event.is_empty():
		_log(str(event.get("text", "")))
		EventDeck.apply_effects(event.get("effects", {}), Rooms.current_id)


func _on_hotspot(spot: Dictionary) -> void:
	var entries: Array = []
	for action in spot.get("actions", []):
		var cost := int(action.get("cost", 1))
		entries.append({
			"label": str(action.get("label", "…")),
			"hint": ("%d action%s" % [cost, "" if cost == 1 else "s"]) if cost > 0 else "free",
			"enabled": GameState.can_spend(cost),
			"action": func(): _perform(action, spot),
		})
	# Fallen liegen im Raum, nicht am Hotspot — sie tauchen hier als Extra auf.
	if Crafting.traps.has(Rooms.current_id) and str(spot.get("id", "")) in ["coal", "cases", "timber"]:
		entries.append({
			"label": "Check the snare", "hint": "free", "enabled": true,
			"action": func(): _log(Crafting.collect_trap(Rooms.current_id)),
		})
	entries.append({"label": "Look at it", "hint": "free", "enabled": true,
		"action": func(): _log(str(spot.get("look", "")))})
	entries.append({"label": "Step back", "hint": "", "enabled": true, "action": func(): pass})
	_open_menu(str(spot.get("name", "")), str(spot.get("look", "")), entries)


func _perform(action: Dictionary, spot: Dictionary) -> void:
	var cost := int(action.get("cost", 1))
	if cost > 0 and not GameState.spend_action(cost):
		_log("You are too tired to do that today.")
		return

	match str(action.get("type", "")):
		"search": _do_search(action, spot)
		"cook": _do_cook()
		"radio": _do_radio()
		"telephone": _do_telephone()
		"fuse_box": _open_fuse_box()
		"dismantle":
			var boards := int(action.get("boards", 2))
			Inventory.add_carried("board", boards)
			_log("You break it up. %d boards." % boards)
		"plant": _log(Garden.plant())
		"water": _log(Garden.water())
		"harvest": _log(Garden.harvest())
		"front_door": _do_front_door()
		"window": GameState.end_run("THE_WINDOW", "You broke the glass and went out into the garden.")
		_: _log("Nothing happens.")


func _do_search(action: Dictionary, spot: Dictionary) -> void:
	var spot_id := str(spot.get("id", ""))
	if Rooms.is_searched(Rooms.current_id, spot_id):
		_log("You have been through this already.")
		return
	if Rooms.search_hotspot(Rooms.current_id, spot_id, action).is_empty():
		_log("Nothing you can use.")


func _do_cook() -> void:
	if Rooms.light_of("kitchen") < Rooms.Light.ELECTRIC and not Specials.can_cook_anywhere():
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
	if (GameState.day >= 12 or GameState.radio_reads_names) and randf() < 0.2:
		Notebook.add_fragment()
		GameState.add_condition("shaken")
		_note("The Radio", "A list of names, read out slowly, with pauses. You write one of them down.")
		return
	_note("The Radio", line)


func _do_telephone() -> void:
	var roll := randf()
	if roll < 0.35:
		Notebook.add_fragment()
		_note("The Telephone", "Someone is already talking when you pick up. You write down what they say before you think about it.")
	elif roll < 0.70:
		GameState.add_condition("shaken")
		_note("The Telephone", "Silence, and then breathing, patient and close.")
	else:
		_note("The Telephone", "A dial tone. The line was cut before you got here. You checked.")


func _do_front_door() -> void:
	match Notebook.attempt_door():
		"TOO_EARLY":
			_note("The Front Door", "It does not move. You do not know enough about this house yet.")
		"INCOMPLETE":
			_note("The Front Door", "There are questions in the notebook you cannot answer. The handle does not turn.")
		"THE_DOOR":
			GameState.end_run("THE_DOOR", "You went out through the front door.")
		"THE_THRESHOLD":
			GameState.end_run("THE_THRESHOLD", "The door opened. It did not close behind you.")
		_:
			for i in Notebook.answers.size():
				Notebook.answers[i] = ""
			GameState.begin_new_day()
			_note("The Front Door", "Nothing. What you brought is gone, and so is the day.")


## --- Tür sichern -------------------------------------------------------------

func _open_door() -> void:
	var id := Rooms.current_id
	var entries: Array = []
	for level in [Rooms.Safety.CLOSED, Rooms.Safety.BLOCKED, Rooms.Safety.BARRICADED]:
		var cost := Rooms.fortify_cost(id, level)
		if cost.is_empty():
			continue
		var label: String = ["", "Close the door", "Push furniture against it", "Board it up"][level]
		var hint := "free" if int(cost.get("actions", 0)) == 0 else "%d actions" % int(cost["actions"])
		if level == Rooms.Safety.BARRICADED:
			hint += " · 2 boards, nails, hammer"
		entries.append({
			"label": label, "hint": hint,
			"enabled": Rooms.can_fortify(id, level),
			"action": func(): _log(Rooms.fortify(id, level)),
		})
	if Inventory.has_carried("trip_line") and not Rooms.has_trip_line(id):
		entries.append({
			"label": "Set the trip line here", "hint": "free", "enabled": true,
			"action": func():
				Inventory.consume_carried("trip_line", 1)
				Rooms.set_trip_line(id, true)
				_log("Cans on a wire, across the doorway."),
		})
	entries.append(_close_entry())

	var body := "%s\nSafety %d of 3." % [Rooms.display_name(id), Rooms.safety_of(id)]
	if int(Rooms.state[id].get("safety_cap", 3)) < 3:
		body += "\nThis door is damaged — it will not hold boards again."
	if Rooms.has_trip_line(id):
		body += "\nA trip line is set here."
	_open_menu("The Door", body, entries)


## --- Bauen -------------------------------------------------------------------

func _open_build() -> void:
	var entries: Array = []
	for recipe_id in Crafting.recipes():
		var recipe: Dictionary = Crafting.recipes()[recipe_id]
		var hint := "%d action%s" % [int(recipe.get("cost", 1)), "" if int(recipe.get("cost", 1)) == 1 else "s"]
		var missing := Crafting.missing_for(str(recipe_id))
		if missing != "":
			hint = missing
		elif recipe_id == "snare" and not Rooms.current_id in Crafting.TRAP_ROOMS:
			hint = "only in the cellar or attic"
		entries.append({
			"label": str(recipe.get("name", recipe_id)), "hint": hint,
			"enabled": Crafting.can_build(str(recipe_id)),
			"action": func(): _log(Crafting.build(str(recipe_id))),
		})
	entries.append(_close_entry())
	_open_menu("Build", "What you can put together with what you have.", entries)


## --- Rucksack ----------------------------------------------------------------

func _open_bag() -> void:
	var entries: Array = []

	for id in Inventory.carried.keys():
		var item_id := str(id)
		if Inventory.is_weightless(item_id):
			continue
		var d := Inventory.item_def(item_id)
		var label := "%s ×%d" % [Inventory.display_name(item_id), int(Inventory.carried[id])]

		if d.has("food"):
			entries.append({"label": "EAT      " + label,
				"hint": "+%d food" % int(d["food"]), "enabled": true,
				"action": func(): _eat(item_id)})
		elif d.has("heals"):
			entries.append({"label": "USE      " + label,
				"hint": "treats " + ", ".join(d["heals"]), "enabled": true,
				"action": func(): _treat_with(item_id)})
		entries.append({"label": "PUT DOWN " + label, "hint": "", "enabled": true,
			"action": func(): Inventory.put_in_stash(item_id, 1)})

	for id in Inventory.stash.keys():
		var item_id := str(id)
		if Inventory.is_weightless(item_id):
			continue
		entries.append({
			"label": "PICK UP  %s ×%d" % [Inventory.display_name(item_id), int(Inventory.stash[id])],
			"hint": "" if Inventory.can_carry(item_id, 1) else "no room",
			"enabled": Inventory.can_carry(item_id, 1),
			"action": func(): Inventory.take_from_stash(item_id, 1)})

	# Sonder-Items belegen keinen Slot — man hat sie einfach.
	for id in Specials.owned:
		var special_id := str(id)
		var d := Specials.spec(special_id)
		entries.append({
			"label": "USE      " + Specials.display_name(special_id),
			"hint": str(d.get("note", "")),
			"enabled": Specials.can_use(special_id),
			"action": func(): _use_special(special_id)})

	entries.append({"label": "Done", "hint": "", "enabled": true, "action": func(): pass})
	_open_menu("Bag — %d of %d slots" % [Inventory.slots_used(), Inventory.CARRY_SLOTS],
		"Only what you carry counts at night.", entries)


## Ortsgebundene Sonder-Items fragen erst, wo sie hin sollen.
func _use_special(id: String) -> void:
	var d := Specials.spec(id)
	if str(d.get("use", "")) == "place":
		var entries: Array = []
		for room in Rooms.state:
			var room_id := str(room)
			if not Rooms.is_available(room_id):
				continue
			entries.append({"label": Rooms.display_name(room_id), "hint": "", "enabled": true,
				"action": func(): _note(Specials.display_name(id), Specials.use(id, room_id))})
		entries.append({"label": "Not yet", "hint": "", "enabled": true, "action": func(): pass})
		_open_menu(Specials.display_name(id), str(d.get("prompt", "Where?")), entries)
		return
	_note(Specials.display_name(id), Specials.use(id))


func _eat(id: String) -> void:
	var result := Inventory.eat(id)
	if not bool(result.get("ok", false)):
		return
	_log("You eat. Food +%d." % int(result.get("food", 0)))
	if bool(result.get("sick", false)):
		_log("That was a mistake.")
	_open_bag()


func _treat_with(id: String) -> void:
	for condition in Inventory.item_def(id).get("heals", []):
		if GameState.has_condition(str(condition)):
			Inventory.treat(str(condition))
			_log("Treated: %s." % str(condition))
			_open_bag()
			return
	_log("Nothing that would help right now.")
	_open_bag()


## --- Sicherungskasten --------------------------------------------------------

func _open_fuse_box() -> void:
	var entries: Array = []
	for id in Rooms.state:
		var room_id := str(id)
		if not Rooms.is_available(room_id):
			continue
		var powered := bool(Rooms.state[id].get("has_fuse", false))
		entries.append({
			"label": ("REMOVE  " if powered else "POWER   ") + Rooms.display_name(room_id),
			"hint": "", "enabled": powered or _fuses_in_use() < 3,
			"action": func(): _set_fuse(room_id, not powered)})
	entries.append(_close_entry())
	_open_menu("Fuse Box", "Three fuses. %d in use." % _fuses_in_use(), entries)


func _set_fuse(room_id: String, on: bool) -> void:
	Rooms.set_fuse(room_id, on)
	_log("%s %s." % [Rooms.display_name(room_id), "has light" if on else "goes dark"])


func _fuses_in_use() -> int:
	var count := 0
	for id in Rooms.state:
		if bool(Rooms.state[id].get("has_fuse", false)):
			count += 1
	return count


## --- Notizbuch ---------------------------------------------------------------

func _open_notebook() -> void:
	var entries: Array = []
	for i in Notebook.QUESTIONS.size():
		var index: int = i
		var answer := str(Notebook.answers[i])
		var label := "%d. %s" % [i + 1, Notebook.QUESTIONS[i]]
		var hint := answer if answer != "" else "%d of %d fragments" % [
			Notebook.fragments[i], Notebook.FRAGMENTS_PER_QUESTION]
		entries.append({
			"label": label, "hint": hint,
			"enabled": Notebook.can_answer(i),
			"action": func(): _open_answers(index)})
	entries.append(_close_entry())
	_open_menu("Notebook", "Answer all four, then try the front door.", entries)


func _open_answers(question: int) -> void:
	var entries: Array = []
	var answers: Array = Notebook.ANSWERS[question]
	for i in answers.size():
		var index: int = i
		var out := Notebook.is_excluded(question, i)
		entries.append({
			"label": ("— " if out else "  ") + str(answers[i]),
			"hint": "ruled out" if out else "", "enabled": not out,
			"action": func():
				Notebook.set_answer(question, index)
				_log("Written down: %s" % str(answers[index]))
				_open_notebook()})
	entries.append({"label": "Back", "hint": "", "enabled": true, "action": func(): _open_notebook()})
	var left := Notebook.remaining_answers(question).size()
	var body := "%s\n\n%s" % [str(Notebook.QUESTIONS[question]),
		"One left." if left == 1 else "%d still possible." % left]
	_open_menu("Question %d" % (question + 1), body, entries)


## --- Karte -------------------------------------------------------------------

func _open_map() -> void:
	var body := ""
	for id in Rooms.state:
		var room_id := str(id)
		if not Rooms.is_available(room_id):
			continue
		var marks: Array[String] = []
		if Rooms.light_of(room_id) >= Rooms.Light.ELECTRIC: marks.append("powered")
		elif Rooms.light_of(room_id) >= Rooms.Light.PLACED: marks.append("lit")
		if Rooms.safety_of(room_id) >= Rooms.Safety.BARRICADED: marks.append("boarded")
		if Rooms.has_trip_line(room_id): marks.append("trip line")
		if Crafting.traps.has(room_id): marks.append("snare")
		if Rooms.has_unsearched(room_id): marks.append("unsearched")
		body += "%s%s%s\n" % [
			"> " if room_id == Rooms.current_id else "  ",
			Rooms.display_name(room_id),
			"  — " + ", ".join(marks) if not marks.is_empty() else ""]
	_open_menu("The House", body, [_close_entry()])


## --- Schlaf und Nacht --------------------------------------------------------

func _open_sleep() -> void:
	var id := Rooms.current_id
	var carrying: Array[String] = []
	for item_id in Inventory.carried.keys():
		if not Inventory.is_weightless(str(item_id)):
			carrying.append("%s ×%d" % [Inventory.display_name(str(item_id)), int(Inventory.carried[item_id])])
	var body := "%s\n\n%s\n\nYou are carrying: %s" % [
		Rooms.display_name(id), Rooms.sleep_assessment(id),
		", ".join(carrying) if not carrying.is_empty() else "nothing"]

	var shaken := GameState.has_condition("shaken")
	_open_menu("Sleep", body, [
		{"label": "One segment", "hint": "energy 2", "enabled": true,
		 "action": func(): DayCycle.sleep(1)},
		{"label": "Two segments", "hint": "energy 4", "enabled": not shaken,
		 "action": func(): DayCycle.sleep(2)},
		{"label": "The whole night", "hint": "energy 6", "enabled": not shaken,
		 "action": func(): DayCycle.sleep(3)},
		{"label": "Not yet", "hint": "", "enabled": true, "action": func(): pass},
	])


## Zeigt ein Problem und daneben, was im Rucksack dagegen hilft.
## Es gibt keine Verhaltensoptionen — nur Gegenstände oder gar nichts.
func _on_problem_event(event: Dictionary, solutions: Array) -> void:
	_pending_problem = event
	_entries = solutions
	var options: Array = []
	for entry in solutions:
		options.append({
			"label": EventDeck.solution_label(entry["solution"]),
			"hint": "use", "enabled": true})
	options.append({
		"label": "You have nothing for this" if solutions.is_empty() else "Do nothing",
		"hint": "", "enabled": true})
	dialog.show_dialog(str(event.get("title", "You wake up")), str(event.get("text", "")), options)


func _resolve_problem(index: int) -> void:
	var event := _pending_problem
	var solutions := _entries
	_pending_problem = {}
	_entries = []
	dialog.close()
	var solution_index := -1
	if index < solutions.size():
		solution_index = int(solutions[index]["index"])
	for line in DayCycle.solve(event, solution_index):
		_log(line)


func _on_night_finished(report: Array) -> void:
	var body := ""
	for line in report:
		if str(line) != "":
			body += "— " + str(line) + "\n"
	if body == "":
		body = "— You slept. Nothing happened.\n"
	if Crafting.ready_count() > 0:
		body += "— Something is in the snare.\n"
	body += "\nENERGY today: %d" % GameState.energy
	_open_menu("Day %d" % GameState.day, body,
		[{"label": "Get up", "hint": "", "enabled": true,
		  "action": func(): DayCycle.begin_day()}])


## --- Sonstiges ---------------------------------------------------------------

func _toggle_light() -> void:
	if Inventory.toggle_flashlight():
		_log("The flashlight works. One battery a day.")
	elif Inventory.has("battery"):
		_log("Off.")
	else:
		_log("No batteries.")
	_refresh()


func _note(title: String, body: String) -> void:
	_open_menu(title, body, [_close_entry()])


func _on_run_ended(result: String, detail: String) -> void:
	var body := "%s\n\nDay %d.\nFragments found: %d of 12." % [
		detail, GameState.day, Notebook.total_fragments()]
	body += "\n\nThere is no saved game. There never was."
	_open_menu(result.replace("_", " "), body, [
		{"label": "Start again", "hint": "", "enabled": true, "action": func():
			DayCycle.start_run()
			_log("The door will not open. It is getting dark.")}])


func _log(line: String) -> void:
	if line == "":
		return
	_log_lines.append(line)
	while _log_lines.size() > 2:
		_log_lines.pop_front()
	log_label.text = "\n".join(_log_lines)


func _unhandled_input(event: InputEvent) -> void:
	if dialog.visible:
		return
	if event.is_action_pressed("open_sleep"):
		_open_sleep()
	elif event.is_action_pressed("toggle_light"):
		_toggle_light()
	elif event.is_action_pressed("open_map"):
		_open_map()

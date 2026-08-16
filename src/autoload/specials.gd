extends Node
## Die Sonder-Items: Verteilung, Besitz und Wirkung.
##
## Pro Durchlauf werden fünf aus dem Pool gezogen und im Haus versteckt.
## Gefunden werden sie beim Durchsuchen — nicht über die Loot-Tabellen,
## damit sie sich wie ein Fund anfühlen und nicht wie eine Dose Bohnen.

signal special_found(id: String)
signal special_used(id: String)

const DB := preload("res://content/special_items_db.gd")

## Chance, dass ein durchsuchter Hotspot ein hier verstecktes Sonder-Item hergibt.
const FIND_CHANCE := 0.35

var in_run: Array[String] = []        ## welche fünf sind in diesem Durchlauf dabei
var hidden: Dictionary = {}           ## room_id -> Array[String]
var owned: Array[String] = []         ## gefunden und noch nicht verbraucht
var used: Array[String] = []
## Laufende Wirkungen
var battery_room := ""
var battery_days_left := 0
var sleep_pills_armed := false
var salts_debt := 0                   ## Tage mit ENERGY −2 durch Riechsalz
var morphine_debt := 0


func reset() -> void:
	in_run.clear()
	hidden.clear()
	owned.clear()
	used.clear()
	battery_room = ""
	battery_days_left = 0
	sleep_pills_armed = false
	salts_debt = 0
	morphine_debt = 0
	_draw_for_run()
	_hide_them()


## --- Verteilung --------------------------------------------------------------

func _draw_for_run() -> void:
	var pool: Array[String] = []
	for id in DB.SPECIALS:
		for i in int(DB.SPECIALS[id].get("weight", 1)):
			pool.append(str(id))
	pool.shuffle()

	# Garantie: mindestens eines aus Gruppe A. Ohne das besteht ein Durchlauf
	# im schlimmsten Fall nur aus Glücksspiel und Notausgängen.
	var group_a: Array[String] = []
	for id in DB.SPECIALS:
		if str(DB.SPECIALS[id].get("group", "")) == "A":
			group_a.append(str(id))
	group_a.shuffle()
	in_run.append(group_a[0])

	for id in pool:
		if in_run.size() >= DB.PICKS:
			break
		if not id in in_run:
			in_run.append(id)


func _hide_them() -> void:
	for id in in_run:
		var rooms: Array = DB.SPECIALS[id].get("rooms", [])
		if rooms.is_empty():
			continue
		var room := str(rooms[randi() % rooms.size()])
		if not hidden.has(room):
			hidden[room] = []
		hidden[room].append(id)


## Wird beim Durchsuchen aufgerufen. Gibt die ID zurück, wenn etwas gefunden wurde.
func try_find(room_id: String) -> String:
	if not hidden.has(room_id) or hidden[room_id].is_empty():
		return ""
	if randf() > FIND_CHANCE:
		return ""
	var id := str(hidden[room_id].pop_back())
	owned.append(id)
	special_found.emit(id)
	return id


func has(id: String) -> bool:
	return id in owned


func spec(id: String) -> Dictionary:
	return DB.SPECIALS.get(id, {})


func display_name(id: String) -> String:
	return str(spec(id).get("name", id))


## --- Wirkungen, die andere Systeme abfragen ----------------------------------

## Der Spirituskocher macht den Herd unabhängig vom Sicherungskasten.
func can_cook_anywhere() -> bool:
	return has("camp_stove") and Inventory.has("lamp_oil")


## Die Dietriche öffnen Türen, ohne sie zu beschädigen.
func opens_doors_cleanly() -> bool:
	return has("lockpicks")


## Der Wecker sperrt Move-Ereignisse — und macht die Nacht etwas lauter.
func blocks_move_events() -> bool:
	return has("alarm_clock")


func night_chance_modifier(room_id: String) -> int:
	var value := 0
	if has("alarm_clock"):
		value += 5
	if has("second_flashlight") and Inventory.flashlight_on and room_id == Rooms.current_id:
		value += 10
	return value


## Die Autobatterie ist ein vierter Stromkreis auf Zeit.
func powers(room_id: String) -> bool:
	return battery_days_left > 0 and battery_room == room_id


func energy_modifier() -> int:
	var value := 0
	if salts_debt > 0:
		value -= 2
	if morphine_debt > 0:
		value -= 1
	return value


## --- Benutzen ----------------------------------------------------------------

## Kann das Item jetzt benutzt werden? Ortsgebundene brauchen den richtigen Raum.
func can_use(id: String) -> bool:
	if not has(id):
		return false
	match id:
		"morphine":
			return not GameState.conditions.is_empty()
		"childs_drawing":
			return not Notebook.all_answered()
		"flare":
			return true
	return true


## Benutzt ein Sonder-Item. Gibt den Meldungstext zurück.
func use(id: String, target_room: String = "") -> String:
	if not has(id):
		return ""
	var d := spec(id)
	var consumed := str(d.get("use", "consume")) != "passive"

	var message := ""
	match id:
		"padlock_chain":
			var room := target_room if target_room != "" else Rooms.current_id
			Rooms.set_safety(room, Rooms.Safety.BARRICADED)
			Rooms.state[room]["locked_forever"] = true
			message = str(d.get("done", "Done."))
		"car_battery":
			battery_room = target_room if target_room != "" else Rooms.current_id
			battery_days_left = int(d.get("days", 6))
			Rooms.set_fuse(battery_room, true)
			message = str(d.get("done", "Done."))
		"sleeping_pills":
			sleep_pills_armed = true
			message = "You will not wake tonight. That is the point, and the price."
		"smelling_salts":
			GameState.energy += 2
			GameState.energy_max += 2
			GameState.energy_changed.emit(GameState.energy, GameState.energy_max)
			salts_debt = 2
			message = "Your head clears. It will not last."
		"morphine":
			for condition in GameState.conditions.keys():
				GameState.remove_condition(str(condition))
			morphine_debt = 3
			message = "Everything goes quiet, including whatever was wrong."
		"flare":
			if GameState.day >= 14:
				GameState.rescue_day -= 2
				message = "Somebody sees it. You do not know that yet, but somebody does."
			else:
				message = "It burns out over an empty field. Nobody is looking yet."
		"jar_unlabelled":
			if randf() < 0.5:
				GameState.add_food(60)
				message = "It was food. It was even good."
			else:
				GameState.add_condition("fevered")
				message = "It was not food."
		"visitors_book":
			Notebook.add_fragment()
			GameState.radio_reads_names = true
			message = "You write your own name under your own name."
		"covered_mirror":
			Notebook.add_fragment()
			Notebook.add_fragment()
			Rooms.cap_safety(Rooms.current_id, Rooms.Safety.BLOCKED)
			message = "Two things become clear. This room will not feel closed again."
		"childs_drawing":
			Notebook.reveal_answer(3)
			message = "The cross is where it has to go. You do not know how you know."
		"warm_key":
			Notebook.add_fragment()
			message = "It fits the door you slept behind. From the outside."
		"photograph_now":
			Notebook.add_fragment()
			GameState.add_condition("shaken")
			message = "You put it face down and then you turn it back over."
		_:
			message = str(d.get("note", "Nothing happens."))

	if consumed:
		owned.erase(id)
		used.append(id)
	special_used.emit(id)
	return message


## --- Tageswechsel ------------------------------------------------------------

func advance_day() -> Array[String]:
	var messages: Array[String] = []
	if battery_days_left > 0:
		battery_days_left -= 1
		if battery_days_left == 0 and battery_room != "":
			Rooms.set_fuse(battery_room, false)
			messages.append("The car battery is flat.")
			battery_room = ""
	if salts_debt > 0:
		salts_debt -= 1
	if morphine_debt > 0:
		morphine_debt -= 1
	sleep_pills_armed = false
	return messages

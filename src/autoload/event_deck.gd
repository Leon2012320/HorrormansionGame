extends Node
## Das Ereignis-System — die einzige Bedrohung im Spiel.
##
## Zieht gewichtet aus den Decks in content/events_db.gd und wendet die
## Fairness-Regeln aus docs/GAME_DESIGN.md Abschnitt 4.4 an.
## Es gibt bewusst keine Gegner-KI: alles läuft über diese Ziehungen.

signal event_drawn(event: Dictionary)
signal effect_applied(text: String)

const EventsDB := preload("res://content/events_db.gd")

## Grundchance pro Schlaf-Segment, in Prozentpunkten.
const BASE_NIGHT_CHANCE := 45
const DAY_CHANCE := 4

## Abzüge auf die Ziehungschance.
const SAFETY_BONUS := {0: 0, 1: 0, 2: -10, 3: -20}
const LIGHT_BONUS := {0: 0, 1: 0, 2: -10, 3: -10}

var _drawn_today: Array[String] = []
var _drawn_this_run: Array[String] = []
var _damage_this_night := false
var _mark_this_night := false
var _last_night_was_harsh := false


func reset() -> void:
	_drawn_today.clear()
	_drawn_this_run.clear()
	_damage_this_night = false
	_mark_this_night = false
	_last_night_was_harsh = false


func begin_day() -> void:
	_drawn_today.clear()


func begin_night() -> void:
	_damage_this_night = false
	_mark_this_night = false


## Wahrscheinlichkeit in Prozent, dass in einem Segment etwas gezogen wird.
func night_chance(room_id: String) -> int:
	if GameState.day <= 1:
		return 0  # Die erste Nacht ist immer ruhig.
	var chance := BASE_NIGHT_CHANCE
	chance += int(SAFETY_BONUS.get(Rooms.safety_of(room_id), 0))
	chance += int(LIGHT_BONUS.get(Rooms.light_of(room_id), 0))
	if _last_night_was_harsh:
		chance -= 15  # Nach einer sehr schlechten Nacht ist die nächste milder.
	return clampi(chance, 5, 90)


## Zieht ein Nachtereignis oder gibt ein leeres Dictionary zurück.
func draw_night_event(room_id: String) -> Dictionary:
	if randi() % 100 >= night_chance(room_id):
		return {}
	var category := _pick_category(room_id)
	if category == "":
		return {}
	var event := _pick_from(category, room_id)
	if event.is_empty():
		return {}
	_note_drawn(event)
	event_drawn.emit(event)
	return event


func draw_day_event() -> Dictionary:
	if randi() % 100 >= DAY_CHANCE:
		return {}
	var category := "ambient"
	# Die leise Hilfe: kurz vor dem Verhungern werden Funde dreimal so wahrscheinlich.
	var supply_weight := 30 if GameState.food >= 25 else 90
	if randi() % (70 + supply_weight) >= 70:
		category = "supply"
	var event := _pick_from(category, Rooms.current_id)
	if event.is_empty():
		return {}
	_note_drawn(event)
	event_drawn.emit(event)
	return event


## --- Auswahl -----------------------------------------------------------------

func _pick_category(room_id: String) -> String:
	var pool: Array[String] = []
	for category in EventsDB.NIGHT_WEIGHTS:
		if category == "damage" and _damage_this_night:
			continue
		if category == "theft" and _damage_this_night:
			continue
		if category == "move" and GameState.day < 5:
			continue
		var weight := int(EventsDB.NIGHT_WEIGHTS[category])
		for i in weight:
			pool.append(category)
	if pool.is_empty():
		return ""
	# Die Stolperschnur wandelt Diebstahl in ein lösbares Problem um.
	var picked: String = pool[randi() % pool.size()]
	if picked == "theft" and Inventory.has_carried("trip_line"):
		return "problem"
	return picked


func _pick_from(category: String, room_id: String) -> Dictionary:
	var candidates: Array = []
	var weights: Array[int] = []
	for event in EventsDB.EVENTS:
		if str(event.get("category", "")) != category:
			continue
		if not _conditions_met(event, room_id):
			continue
		candidates.append(event)
		weights.append(int(event.get("weight", 1)))
	if candidates.is_empty():
		return {}
	var total := 0
	for w in weights:
		total += w
	var roll := randi() % maxi(total, 1)
	for i in candidates.size():
		roll -= weights[i]
		if roll < 0:
			return candidates[i]
	return candidates[0]


func _conditions_met(event: Dictionary, room_id: String) -> bool:
	var id := str(event.get("id", ""))
	if id in _drawn_today:
		return false
	if bool(event.get("once", false)) and id in _drawn_this_run:
		return false
	if GameState.day < int(event.get("from_day", 1)):
		return false
	if event.has("max_safety") and Rooms.safety_of(room_id) > int(event["max_safety"]):
		return false
	if event.has("min_safety") and Rooms.safety_of(room_id) < int(event["min_safety"]):
		return false
	if event.has("max_light") and Rooms.light_of(room_id) > int(event["max_light"]):
		return false
	if event.has("requires_bed") and bool(event["requires_bed"]):
		if not bool(Rooms.def(room_id).get("has_bed", false)):
			return false
	if event.has("requires_window") and bool(event["requires_window"]):
		if not bool(Rooms.def(room_id).get("has_window", false)):
			return false
	if event.has("requires_condition"):
		if not GameState.has_condition(str(event["requires_condition"])):
			return false
	if bool(event.get("requires_fuse", false)):
		var any_fuse := false
		for room in Rooms.state:
			if bool(Rooms.state[room].get("has_fuse", false)):
				any_fuse = true
		if not any_fuse:
			return false
	if bool(event.get("ground_or_cellar", false)):
		if not room_id in ["entrance", "parlor", "library", "dining", "kitchen", "conservatory", "cellar"]:
			return false
	if bool(event.get("requires_food_stock", false)) and _food_items() < 2:
		return false
	if bool(event.get("requires_perishables", false)) and _perishables().is_empty():
		return false
	return true


func _food_items() -> int:
	var count := 0
	for item_id in EventsDB.ItemsDB.ITEMS:
		if str(EventsDB.ItemsDB.ITEMS[item_id].get("category", "")) == "food":
			count += Inventory.count(str(item_id))
	return count


func _perishables() -> Array[String]:
	var result: Array[String] = []
	for item_id in EventsDB.ItemsDB.ITEMS:
		if EventsDB.ItemsDB.ITEMS[item_id].has("spoils_after") and Inventory.has(str(item_id)):
			result.append(str(item_id))
	return result


## --- Lösungen ----------------------------------------------------------------

## Welche der hinterlegten Lösungen kann der Spieler gerade wirklich benutzen?
## Das ist der Kern des neuen Ereignis-Systems: nicht "was willst du tun",
## sondern "was hast du dabei".
func available_solutions(event: Dictionary) -> Array:
	var result: Array = []
	var solutions: Array = event.get("solutions", [])
	for i in solutions.size():
		if _solution_possible(solutions[i]):
			result.append({"index": i, "solution": solutions[i]})
	return result


## Prüft NUR das Getragene. Das ist der Kern des Systems: die sechs Slots
## entscheiden über die Nacht, nicht der Vorratsstapel drei Räume weiter.
func _solution_possible(solution: Dictionary) -> bool:
	if bool(solution.get("kitchen_powered", false)):
		return Rooms.light_of("kitchen") >= Rooms.Light.ELECTRIC
	if solution.has("tool") and not Inventory.has_carried(str(solution["tool"])):
		return false
	for id in solution.get("needs", {}):
		if not Inventory.has_carried(str(id), int(solution["needs"][id])):
			return false
	return true


## Beschreibt eine Lösung so, wie sie im Dialog steht: "Board ×1 + Hammer".
func solution_label(solution: Dictionary) -> String:
	var parts: Array[String] = []
	for id in solution.get("needs", {}):
		var amount := int(solution["needs"][id])
		parts.append(Inventory.display_name(str(id)) + ("" if amount == 1 else " ×%d" % amount))
	if solution.has("tool"):
		parts.append(Inventory.display_name(str(solution["tool"])))
	if bool(solution.get("kitchen_powered", false)):
		parts.append("power in the kitchen")
	return " + ".join(parts)


## Verbraucht, was die Lösung kostet. Werkzeuge bleiben erhalten —
## außer sie sind ausdrücklich als Verbrauch markiert (Stolperschnur).
func consume_for(solution: Dictionary) -> void:
	for id in solution.get("needs", {}):
		Inventory.consume_carried(str(id), int(solution["needs"][id]))
	if bool(solution.get("consumes_tool", false)) and solution.has("tool"):
		Inventory.consume_carried(str(solution["tool"]), 1)


func _note_drawn(event: Dictionary) -> void:
	var id := str(event.get("id", ""))
	_drawn_today.append(id)
	_drawn_this_run.append(id)
	match str(event.get("category", "")):
		"damage", "theft":
			_damage_this_night = true
		"mark":
			_mark_this_night = true


## --- Wirkung -----------------------------------------------------------------

## Wendet einen Effekt-Block an und gibt die Meldung für den Night Report zurück.
## Effekte sind absichtlich Daten, keine Funktionen — so lassen sich neue
## Ereignisse anlegen, ohne Code anzufassen.
func apply_effects(effects: Dictionary, room_id: String) -> Array[String]:
	var log: Array[String] = []

	if effects.has("energy"):
		GameState.energy_max = maxi(GameState.energy_max + int(effects["energy"]), GameState.ENERGY_MIN)
		GameState.energy = mini(GameState.energy, GameState.energy_max)
		GameState.energy_changed.emit(GameState.energy, GameState.energy_max)

	if effects.has("food"):
		GameState.add_food(int(effects["food"]))
		log.append("Food %+d." % int(effects["food"]))

	if effects.has("condition"):
		var id := str(effects["condition"])
		GameState.add_condition(id)
		log.append("You are %s." % id)
		if id in ["injured", "sick", "fevered", "bleeding"]:
			_last_night_was_harsh = true

	if effects.has("heal"):
		GameState.remove_condition(str(effects["heal"]))

	if effects.has("set_safety"):
		Rooms.set_safety(room_id, int(effects["set_safety"]))

	if effects.has("permanent_safety"):
		Rooms.set_safety(room_id, Rooms.safety_of(room_id) + int(effects["permanent_safety"]))
		log.append("That window will not open again.")

	if effects.has("light"):
		Rooms.place_candle(room_id, 1)

	if effects.has("steal_food"):
		var taken := 0
		for i in int(effects["steal_food"]):
			for food_id in EventsDB.ItemsDB.ITEMS:
				if str(EventsDB.ItemsDB.ITEMS[food_id].get("category", "")) != "food":
					continue
				if Inventory.consume(str(food_id), 1):
					taken += 1
					break
		if taken > 0:
			log.append("%d of your stores are gone." % taken)

	if effects.has("spoil_perishables"):
		for spoiled_id in _perishables():
			var amount := Inventory.count(spoiled_id)
			Inventory.consume(spoiled_id, amount)
			Inventory.add_stash("food_spoiled", amount)
		log.append("Everything soft has turned.")

	if effects.has("damage_safety"):
		Rooms.damage_safety(room_id, int(effects["damage_safety"]))
		log.append("The barricade has been worked at.")
		_last_night_was_harsh = true

	if effects.has("cap_safety"):
		Rooms.cap_safety(room_id, int(effects["cap_safety"]))

	if effects.has("blow_fuse"):
		for id in Rooms.state:
			if bool(Rooms.state[id].get("has_fuse", false)):
				Rooms.set_fuse(id, false)
				Inventory.consume("fuse", 1)
				log.append("A fuse has blown in %s." % Rooms.display_name(id))
				break

	if effects.has("steal"):
		var taken := Inventory.remove_random()
		if taken != "":
			log.append("%s is missing." % Inventory.display_name(taken))
			_last_night_was_harsh = true

	if effects.has("steal_item"):
		var id := str(effects["steal_item"])
		if Inventory.consume(id, 1):
			log.append("%s is missing." % Inventory.display_name(id))

	if effects.has("give"):
		for id in effects["give"]:
			var amount := int(effects["give"][id])
			Inventory.add_carried(str(id), amount)
			log.append("Found: %s ×%d." % [Inventory.display_name(str(id)), amount])

	if effects.has("clue"):
		Notebook.add_fragment()
		log.append("You have written something down.")

	if effects.has("smudge"):
		if Notebook.smudge_fragment():
			log.append("A page in the notebook is no longer readable.")

	if effects.has("reveal_room"):
		for id in Rooms.state:
			if not Rooms.is_available(id):
				Rooms.state[id]["unlocked"] = true
				log.append("You know where %s is now." % Rooms.display_name(id))
				break

	if effects.has("move_to"):
		var target := str(effects["move_to"])
		if Rooms.def(target).size() > 0:
			if bool(effects.get("drop_carried", false)):
				for id in Inventory.carried.keys():
					Inventory.stash[id] = int(Inventory.stash.get(id, 0)) + int(Inventory.carried[id])
				Inventory.carried.clear()
				Inventory.carried_changed.emit()
				log.append("Everything you were carrying is in the other room.")
			Rooms.current_id = target
			Rooms.room_changed.emit(target)
			log.append("You are in %s." % Rooms.display_name(target))

	if effects.has("end_night"):
		log.append("You did not sleep again.")

	for line in log:
		effect_applied.emit(line)
	return log


## Wählt aus einer gewichteten Ergebnisliste, wie sie Wake-Optionen benutzen.
func roll_outcome(outcomes: Array) -> Dictionary:
	if outcomes.is_empty():
		return {}
	var total := 0
	for o in outcomes:
		total += int(o.get("weight", 1))
	var roll := randi() % maxi(total, 1)
	for o in outcomes:
		roll -= int(o.get("weight", 1))
		if roll < 0:
			return o
	return outcomes[0]

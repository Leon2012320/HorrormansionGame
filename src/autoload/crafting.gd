extends Node
## Die vier Bau-Rezepte und die Fallen.
##
## Mehr Crafting gibt es nicht — das Spiel ist kein Bastelsimulator.
## Liegt als Autoload und nicht in der Oberfläche, damit der Smoke-Test
## dieselbe Logik benutzt wie ein echter Spieler.

signal built(recipe_id: String)
signal trap_caught(room_id: String)

const ItemsDB := preload("res://content/items_db.gd")

## Fallen: room_id -> {"set_day": int}
const MAX_TRAPS := 3
const TRAP_DAYS := 2       ## alle zwei Tage fängt eine Falle etwas
const TRAP_FOOD := 25
const TRAP_ROOMS := ["cellar", "attic"]

var traps: Dictionary = {}


func reset() -> void:
	traps.clear()


## --- Rezepte -----------------------------------------------------------------

func recipes() -> Dictionary:
	return ItemsDB.RECIPES


func can_build(recipe_id: String) -> bool:
	var recipe: Dictionary = ItemsDB.RECIPES.get(recipe_id, {})
	if recipe.is_empty():
		return false
	if not GameState.can_spend(int(recipe.get("cost", 1))):
		return false
	if recipe.has("tool") and not Inventory.has(str(recipe["tool"])):
		return false
	for id in recipe.get("needs", {}):
		if not Inventory.has(str(id), int(recipe["needs"][id])):
			return false
	# Die Barrikade ist ein Sonderfall: sie gehört zur Tür, nicht ins Inventar.
	if recipe_id == "barricade":
		return Rooms.can_fortify(Rooms.current_id, Rooms.Safety.BARRICADED)
	if recipe_id == "snare":
		return traps.size() < MAX_TRAPS and Rooms.current_id in TRAP_ROOMS
	return true


func missing_for(recipe_id: String) -> String:
	var recipe: Dictionary = ItemsDB.RECIPES.get(recipe_id, {})
	var parts: Array[String] = []
	for id in recipe.get("needs", {}):
		var amount := int(recipe["needs"][id])
		if not Inventory.has(str(id), amount):
			parts.append(Inventory.display_name(str(id)))
	if recipe.has("tool") and not Inventory.has(str(recipe["tool"])):
		parts.append(Inventory.display_name(str(recipe["tool"])))
	if parts.is_empty():
		return ""
	return "needs " + ", ".join(parts)


func build(recipe_id: String) -> String:
	if not can_build(recipe_id):
		var missing := missing_for(recipe_id)
		return missing if missing != "" else "Not here, not now."

	if recipe_id == "barricade":
		return Rooms.fortify(Rooms.current_id, Rooms.Safety.BARRICADED)

	var recipe: Dictionary = ItemsDB.RECIPES[recipe_id]
	if not GameState.spend_action(int(recipe.get("cost", 1))):
		return "You are too tired for that today."
	for id in recipe.get("needs", {}):
		Inventory.consume(str(id), int(recipe["needs"][id]))
	built.emit(recipe_id)

	match recipe_id:
		"trip_line":
			Inventory.add_carried("trip_line", 1)
			return "Wire and two empty tins. It will make enough noise."
		"snare":
			traps[Rooms.current_id] = {"set_day": GameState.day}
			return "Set. Check it in a couple of days."
		"torch":
			Inventory.add_carried("torch", 1)
			return "It will burn for about a day."
	return "Done."


## --- Fallen ------------------------------------------------------------------

func trap_ready(room_id: String) -> bool:
	if not traps.has(room_id):
		return false
	return GameState.day - int(traps[room_id]["set_day"]) >= TRAP_DAYS


## Falle leeren — kostet keine Handlung, das Aufstellen hat schon gekostet.
func collect_trap(room_id: String) -> String:
	if not traps.has(room_id):
		return "No snare here."
	if not trap_ready(room_id):
		return "Nothing in it yet."
	traps[room_id]["set_day"] = GameState.day
	Inventory.add_carried("catch_raw", 1)
	trap_caught.emit(room_id)
	return "Something in the snare. Cook it or risk it."


## Wie viele Fallen sind gerade fällig? Für den Night Report.
func ready_count() -> int:
	var count := 0
	for room_id in traps:
		if trap_ready(str(room_id)):
			count += 1
	return count

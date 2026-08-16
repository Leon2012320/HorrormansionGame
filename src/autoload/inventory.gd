extends Node
## Getragene Gegenstände (6 Slots) und das Lager im gewählten Raum.

signal carried_changed()
signal stash_changed()
signal item_found(id: String, amount: int)

const ItemsDB := preload("res://content/items_db.gd")
const CARRY_SLOTS := 6

## id -> Menge
var carried: Dictionary = {}
var stash: Dictionary = {}
var stash_room := "entrance"
var flashlight_on := false
var match_uses := 0        ## Streichhölzer in der offenen Schachtel


func _ready() -> void:
	reset()


func reset() -> void:
	carried.clear()
	stash.clear()
	stash_room = "entrance"
	flashlight_on = false
	match_uses = 0
	# Startausrüstung: das, was man beim Weglaufen dabei hat.
	add_carried("flashlight", 1)
	add_carried("battery", 3)
	add_carried("matches", 1)
	add_carried("candle", 2)
	carried_changed.emit()


func item_def(id: String) -> Dictionary:
	return ItemsDB.ITEMS.get(id, {})


func display_name(id: String) -> String:
	return str(item_def(id).get("name", id))


func stack_size(id: String) -> int:
	return int(item_def(id).get("stack", 1))


## Wie viele Slots die getragenen Sachen gerade belegen.
## Hinweise und Rückgabe-Gegenstände zählen nicht mit — sie gehören ins
## Notizbuch, nicht in die Tasche.
func slots_used() -> int:
	var used := 0
	for id in carried:
		if is_weightless(str(id)):
			continue
		var per_slot := maxi(stack_size(str(id)), 1)
		used += ceili(float(carried[id]) / float(per_slot))
	return used


func is_weightless(id: String) -> bool:
	return str(item_def(id).get("category", "")) in ["clue", "token"]


func has(id: String, amount: int = 1) -> bool:
	return int(carried.get(id, 0)) + int(stash.get(id, 0)) >= amount


func count(id: String) -> int:
	return int(carried.get(id, 0)) + int(stash.get(id, 0))


## Nur das, was du am Körper trägst. Nachts zählt ausschließlich das:
## was im Lager liegt, nützt um drei Uhr morgens nichts.
func carried_count(id: String) -> int:
	return int(carried.get(id, 0))


func has_carried(id: String, amount: int = 1) -> bool:
	return carried_count(id) >= amount


func consume_carried(id: String, amount: int = 1) -> bool:
	if not has_carried(id, amount):
		return false
	carried[id] = int(carried[id]) - amount
	if int(carried[id]) <= 0:
		carried.erase(id)
	carried_changed.emit()
	return true


## Abends umpacken: aus dem Lager in den Rucksack und zurück. Kostet nichts,
## geht aber nur, wenn du im Lagerraum stehst.
func take_from_stash(id: String, amount: int = 1) -> bool:
	if int(stash.get(id, 0)) < amount or not can_carry(id, amount):
		return false
	stash[id] = int(stash[id]) - amount
	if int(stash[id]) <= 0:
		stash.erase(id)
	carried[id] = int(carried.get(id, 0)) + amount
	carried_changed.emit()
	stash_changed.emit()
	return true


func put_in_stash(id: String, amount: int = 1) -> bool:
	if not has_carried(id, amount):
		return false
	carried[id] = int(carried[id]) - amount
	if int(carried[id]) <= 0:
		carried.erase(id)
	stash[id] = int(stash.get(id, 0)) + amount
	carried_changed.emit()
	stash_changed.emit()
	return true


func can_carry(id: String, amount: int = 1) -> bool:
	if is_weightless(id):
		return true
	var per_slot := maxi(stack_size(id), 1)
	var after := int(carried.get(id, 0)) + amount
	var extra := ceili(float(after) / float(per_slot)) - ceili(float(int(carried.get(id, 0))) / float(per_slot))
	return slots_used() + extra <= CARRY_SLOTS


func add_carried(id: String, amount: int = 1) -> bool:
	if not can_carry(id, amount):
		add_stash(id, amount)
		return false
	carried[id] = int(carried.get(id, 0)) + amount
	carried_changed.emit()
	_note_clue(id, amount)
	item_found.emit(id, amount)
	return true


func add_stash(id: String, amount: int = 1) -> void:
	stash[id] = int(stash.get(id, 0)) + amount
	stash_changed.emit()
	_note_clue(id, amount)
	item_found.emit(id, amount)


## Ein gefundener Hinweis wandert sofort ins Notizbuch — das ist die
## Hauptquelle für Fragmente. Ohne diesen Schritt ist das Geheimnis
## nicht lösbar, egal wie gründlich man sucht.
func _note_clue(id: String, amount: int) -> void:
	var d := item_def(id)
	if str(d.get("category", "")) != "clue":
		return
	for i in amount:
		Notebook.add_fragment(int(d.get("question", -1)))


## Verbraucht aus dem Getragenen, dann aus dem Lager.
func consume(id: String, amount: int = 1) -> bool:
	if not has(id, amount):
		return false
	var left := amount
	var from_carried := mini(int(carried.get(id, 0)), left)
	if from_carried > 0:
		carried[id] = int(carried[id]) - from_carried
		if int(carried[id]) <= 0:
			carried.erase(id)
		left -= from_carried
		carried_changed.emit()
	if left > 0:
		stash[id] = int(stash.get(id, 0)) - left
		if int(stash[id]) <= 0:
			stash.erase(id)
		stash_changed.emit()
	return true


## Nimmt einen zufälligen Gegenstand weg — für Theft-Ereignisse.
func remove_random(pool: Array = []) -> String:
	var candidates: Array = []
	for id in carried:
		if pool.is_empty() or id in pool:
			candidates.append(id)
	for id in stash:
		if (pool.is_empty() or id in pool) and not id in candidates:
			candidates.append(id)
	if candidates.is_empty():
		return ""
	var picked: String = candidates[randi() % candidates.size()]
	consume(picked, 1)
	return picked


func set_stash_room(id: String) -> void:
	stash_room = id
	stash_changed.emit()


## Zieht ein einzelnes Streichholz. Öffnet bei Bedarf eine neue Schachtel.
func use_match() -> bool:
	if match_uses <= 0:
		if not consume("matches", 1):
			return false
		match_uses = int(item_def("matches").get("uses", 8))
	match_uses -= 1
	return true


func toggle_flashlight() -> bool:
	if not flashlight_on and not has("battery"):
		return false
	flashlight_on = not flashlight_on
	return flashlight_on


## Einmal am Tag: die Taschenlampe frisst eine Batterie.
func consume_daily_power() -> bool:
	if not flashlight_on:
		return true
	if consume("battery", 1):
		return true
	flashlight_on = false
	return false


## Behandelt einen Zustand mit dem passenden Mittel. Kostet keine Handlung —
## sich zu verbinden ist keine Tagesaufgabe, das Material zu finden schon.
func treat(condition: String) -> bool:
	for id in ITEMS_WITH_HEALING:
		if not has(id):
			continue
		if not condition in item_def(id).get("heals", []):
			continue
		consume(id, 1)
		GameState.remove_condition(condition)
		return true
	return false


const ITEMS_WITH_HEALING := ["bandage", "pills", "whiskey"]


func eat(id: String) -> Dictionary:
	var d := item_def(id)
	if d.is_empty() or not has(id):
		return {"ok": false}
	consume(id, 1)
	GameState.add_food(int(d.get("food", 0)))
	var result := {"ok": true, "food": int(d.get("food", 0)), "sick": false}
	if randf() < float(d.get("sick_chance", 0.0)):
		GameState.add_condition("sick")
		result["sick"] = true
	if d.get("leaves_empty_tin", false):
		add_stash("can_empty", 1)
	return result

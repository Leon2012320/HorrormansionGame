extends Node
## Die Beete im Wintergarten — die einzige Nahrungsquelle, die nachwächst.
##
## Bewusst als eigenes Autoload und nicht in der Oberfläche, damit der
## Smoke-Test in tools/ dieselbe Logik benutzt wie das echte Spiel.

const ROOM := "conservatory"
const BED_COUNT := 2
const RIPE_DAYS := 5
const RIPE_DAYS_LIT := 4      ## unter elektrischem Licht
const DRY_DAYS := 2           ## zwei Tage ohne Wasser und die Pflanzung stirbt
const YIELD_ITEMS := 2
const SEED_RETURN_CHANCE := 0.5

var beds: Array = []


func _ready() -> void:
	reset()


func reset() -> void:
	beds.clear()
	for i in BED_COUNT:
		beds.append({"planted": -1, "watered": -1})


func ripe_days() -> int:
	return RIPE_DAYS_LIT if Rooms.light_of(ROOM) >= Rooms.Light.ELECTRIC else RIPE_DAYS


func free_beds() -> int:
	var count := 0
	for bed in beds:
		if int(bed["planted"]) < 0:
			count += 1
	return count


func has_ripe() -> bool:
	for bed in beds:
		var planted := int(bed["planted"])
		if planted >= 0 and GameState.day - planted >= ripe_days():
			return true
	return false


func needs_water() -> bool:
	for bed in beds:
		if int(bed["planted"]) >= 0 and GameState.day - int(bed["watered"]) >= 1:
			return true
	return false


func plant() -> String:
	if not Inventory.has("seeds"):
		return "No seeds."
	for bed in beds:
		if int(bed["planted"]) < 0:
			Inventory.consume("seeds", 1)
			bed["planted"] = GameState.day
			bed["watered"] = GameState.day
			return "Planted. It will take about %d days." % ripe_days()
	return "Both beds are already planted."


func water() -> String:
	var count := 0
	for bed in beds:
		if int(bed["planted"]) >= 0:
			bed["watered"] = GameState.day
			count += 1
	if count == 0:
		return "Nothing planted."
	return "Watered %d bed%s." % [count, "" if count == 1 else "s"]


func harvest() -> String:
	for bed in beds:
		var planted := int(bed["planted"])
		if planted < 0:
			continue
		if GameState.day - int(bed["watered"]) >= DRY_DAYS:
			bed["planted"] = -1
			return "This bed died. You did not water it."
		if GameState.day - planted < ripe_days():
			return "Not ready. A few more days."
		bed["planted"] = -1
		Inventory.add_carried("crop_ripe", YIELD_ITEMS)
		if randf() < SEED_RETURN_CHANCE:
			Inventory.add_carried("seeds", 1)
		return "A harvest. Enough for two days if you are careful."
	return "Nothing to harvest."


## Läuft beim Tageswechsel: ungegossene Beete sterben.
func advance_day() -> Array[String]:
	var messages: Array[String] = []
	for bed in beds:
		if int(bed["planted"]) < 0:
			continue
		if GameState.day - int(bed["watered"]) >= DRY_DAYS:
			bed["planted"] = -1
			messages.append("A bed in the conservatory has died.")
	return messages

extends Node
## Räume: Definition, Verbindungen, LIGHT und SAFETY je Raum.
##
## Der Inhalt steht in content/rooms_db.gd als reine Datentabelle.
## Neue Räume anlegen heißt: dort einen Eintrag ergänzen, ein Bild
## unter assets/rooms/ ablegen, fertig. Kein Code nötig.

signal room_changed(id: String)
signal room_state_changed(id: String)
## Feuert, wenn in einem bereits geleerten Möbelstück wieder etwas liegt.
signal restocked_found(room_id: String, hotspot_id: String)

const RoomsDB := preload("res://content/rooms_db.gd")

enum Light { DARK = 0, HANDHELD = 1, PLACED = 2, ELECTRIC = 3 }
enum Safety { OPEN = 0, CLOSED = 1, BLOCKED = 2, BARRICADED = 3 }

## Nach so vielen Tagen liegt in einem durchsuchten Möbelstück wieder etwas.
## Das ist kein Komfort-Zugeständnis, sondern nötig: 33 Hotspots sind bei
## sechs Handlungen am Tag nach fünf Tagen durch, und das Spiel geht zwanzig.
## Erzählerisch ist es das unheimlichste Element im Spiel — jemand räumt auf.
const RESTOCK_DAYS := 4
const RESTOCK_YIELD := 0.5   ## halbe Ausbeute beim zweiten und jedem weiteren Mal

var current_id := "entrance"
## Laufzeitzustand je Raum: light, safety, safety_cap, searched, unlocked
var state: Dictionary = {}


func _ready() -> void:
	reset()


func reset() -> void:
	state.clear()
	for id in RoomsDB.ROOMS:
		var def: Dictionary = RoomsDB.ROOMS[id]
		state[id] = {
			"light": Light.DARK,
			"safety": Safety.OPEN,
			"safety_cap": Safety.BARRICADED,
			"searched": {},
			"unlocked": int(def.get("available_from_day", 1)) <= 1,
			"candle_days_left": 0,
			"has_fuse": false,
			"trip_line": false,
		}
	current_id = "entrance"


func def(id: String) -> Dictionary:
	return RoomsDB.ROOMS.get(id, {})


func current() -> Dictionary:
	return def(current_id)


func display_name(id: String) -> String:
	return str(def(id).get("name", id))


func exits(id: String) -> Array:
	var result: Array = []
	for target in def(id).get("exits", []):
		if is_available(str(target)):
			result.append(target)
	return result


func is_available(id: String) -> bool:
	var d := def(id)
	if d.is_empty():
		return false
	return GameState.day >= int(d.get("available_from_day", 1))


## Laufen kostet nichts — das ist Absicht, siehe GAME_DESIGN 3.2.
func travel_to(id: String) -> bool:
	if not is_available(id):
		return false
	if not id in def(current_id).get("exits", []):
		return false
	current_id = id
	room_changed.emit(id)
	return true


## --- LIGHT -------------------------------------------------------------------

func light_of(id: String) -> int:
	var s: Dictionary = state.get(id, {})
	var value := int(s.get("light", Light.DARK))
	if bool(s.get("has_fuse", false)):
		value = maxi(value, Light.ELECTRIC)
	elif int(s.get("candle_days_left", 0)) > 0:
		value = maxi(value, Light.PLACED)
	if Inventory.flashlight_on and id == current_id:
		value = maxi(value, Light.HANDHELD)
	return value


func place_candle(id: String, days: int = 2) -> void:
	state[id]["candle_days_left"] = days
	room_state_changed.emit(id)


## Kerze aufstellen und anzünden. Kostet keine Handlung, aber eine Kerze
## und ein Streichholz — Licht ist Material, nicht Zeit.
func light_candle(id: String) -> String:
	if int(state.get(id, {}).get("candle_days_left", 0)) > 0:
		return "There is already a candle burning here."
	if not Inventory.has("candle"):
		return "No candles."
	if not Inventory.has("matches") and Inventory.match_uses <= 0:
		return "Nothing to light it with."
	Inventory.consume("candle", 1)
	Inventory.use_match()
	place_candle(id, 2)
	return "The candle takes. It will last about two days."


## Wo es sich lohnt, Licht zu machen: dunkle Räume, in denen noch etwas zu holen ist.
##
## Zählt nur Hotspots, die überhaupt durchsucht werden können. Die Haustür,
## der Herd und die Beete werden nie "durchsucht" — würde man sie mitzählen,
## gälte ihr Raum für immer als unerledigt.
func has_unsearched(id: String) -> bool:
	for spot in hotspots(id):
		if not _is_searchable(spot):
			continue
		if not is_searched(id, str(spot.get("id", ""))):
			return true
	return false


func _is_searchable(spot: Dictionary) -> bool:
	for action in spot.get("actions", []):
		if str(action.get("type", "")) == "search":
			return true
	return false


func set_fuse(id: String, on: bool) -> void:
	state[id]["has_fuse"] = on
	room_state_changed.emit(id)


## --- SAFETY ------------------------------------------------------------------

func safety_of(id: String) -> int:
	var s: Dictionary = state.get(id, {})
	return mini(int(s.get("safety", Safety.OPEN)), int(s.get("safety_cap", Safety.BARRICADED)))


func set_safety(id: String, value: int) -> void:
	state[id]["safety"] = clampi(value, Safety.OPEN, Safety.BARRICADED)
	room_state_changed.emit(id)


## Ereignisse setzen Barrikaden herunter — sie halten nie dauerhaft.
func damage_safety(id: String, amount: int = 1) -> void:
	set_safety(id, safety_of(id) - amount)


## Eine aufgebrochene Tür kommt nie wieder über SAFETY 1 hinaus.
func cap_safety(id: String, cap: int) -> void:
	state[id]["safety_cap"] = mini(int(state[id].get("safety_cap", 3)), cap)
	room_state_changed.emit(id)


## --- Hotspots ----------------------------------------------------------------

func hotspots(id: String) -> Array:
	return def(id).get("hotspots", [])


## "Durchsucht" heißt: seit weniger als RESTOCK_DAYS Tagen angefasst.
func is_searched(room_id: String, hotspot_id: String) -> bool:
	var day := int(state.get(room_id, {}).get("searched", {}).get(hotspot_id, -999))
	return GameState.day - day < RESTOCK_DAYS


func was_searched_before(room_id: String, hotspot_id: String) -> bool:
	return state.get(room_id, {}).get("searched", {}).has(hotspot_id)


func mark_searched(room_id: String, hotspot_id: String) -> void:
	state[room_id]["searched"][hotspot_id] = GameState.day
	room_state_changed.emit(room_id)


## Durchsucht einen Hotspot und legt die Funde ins Inventar.
## Liegt bewusst hier und nicht in der Oberfläche, damit der Smoke-Test
## exakt dieselbe Ausbeute bekommt wie ein echter Spieler.
func search_hotspot(room_id: String, hotspot_id: String, action: Dictionary) -> Array[String]:
	var found: Array[String] = []
	if is_searched(room_id, hotspot_id):
		return found
	# Muss VOR mark_searched stehen — sonst gilt der Nachfüll-Malus sofort.
	var refilled := was_searched_before(room_id, hotspot_id)
	mark_searched(room_id, hotspot_id)

	# Im Dunkeln findest du nur die Hälfte. Erschöpft übersiehst du Dinge.
	var modifier := 1.0
	if light_of(room_id) <= Light.DARK:
		modifier *= 0.6
	if GameState.has_condition("exhausted"):
		modifier *= 0.7
	if refilled:
		modifier *= RESTOCK_YIELD

	for entry in action.get("loot", []):
		if randf() > float(entry.get("chance", 0.5)) * modifier:
			continue
		var amount := 1
		if entry.has("max"):
			amount = randi_range(int(entry.get("min", 1)), int(entry["max"]))
		Inventory.add_carried(str(entry["item"]), amount)
		found.append(str(entry["item"]))
	if refilled and not found.is_empty():
		restocked_found.emit(room_id, hotspot_id)
	return found


## --- Tageswechsel ------------------------------------------------------------

func advance_day() -> void:
	for id in state:
		var left := int(state[id].get("candle_days_left", 0))
		if left > 0:
			state[id]["candle_days_left"] = left - 1
		if not bool(state[id].get("unlocked", false)) and is_available(id):
			state[id]["unlocked"] = true
	room_state_changed.emit(current_id)


## Beschreibt den Schlafplatz in Worten statt in Prozent — siehe GAME_DESIGN 4.1.
func sleep_assessment(id: String) -> String:
	var light := light_of(id)
	var safety := safety_of(id)
	if light <= Light.DARK and safety <= Safety.OPEN:
		return "Dark. Open. You should not sleep here."
	if safety >= Safety.BARRICADED and light >= Light.PLACED:
		return "Boarded up, and something is burning. This is as good as it gets."
	if safety >= Safety.BARRICADED:
		return "Boarded up, but dark."
	if light >= Light.PLACED:
		return "There is light, at least. The door is not much of a door."
	if safety >= Safety.BLOCKED:
		return "Something heavy against the door. It will have to do."
	return "The door is shut. That is all you can say for it."

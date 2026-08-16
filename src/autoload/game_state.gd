extends Node
## Zentraler Spielzustand: Tag, ENERGY, FOOD, Zustände.
##
## Alle Werte stammen aus docs/GAME_DESIGN.md Abschnitt 3.
## Andere Systeme lesen hier, ändern aber nur über die Methoden unten,
## damit die Signale immer sauber feuern.

signal energy_changed(current: int, maximum: int)
signal food_changed(value: int)
signal day_changed(day: int)
signal condition_changed(id: String, active: bool)
signal run_ended(ending: String, detail: String)

const ENERGY_MAX := 8
const ENERGY_MIN := 1
const FOOD_MAX := 100
## Ein normaler Tag mit sechs Handlungen kostet 20 Punkte — also etwa
## eine Konserve alle eineinhalb Tage. Ursprünglich lag der Verbrauch bei 28,
## was der Smoke-Test als unspielbar entlarvt hat: das Haus gibt nicht genug her.
const FOOD_PER_DAY := 8
const FOOD_PER_ACTION := 2
const RESCUE_DAY := 20
const MYSTERY_UNLOCK_DAY := 8

## Zustände: id -> wie viele Tage er schon anliegt.
## Eskalation und Wirkung stehen in CONDITIONS.
const CONDITIONS := {
	"injured":   {"energy": -1, "days_to_escalate": 2, "escalates_to": "bleeding"},
	"sick":      {"energy": -1, "days_to_escalate": 3, "escalates_to": "fevered"},
	"shaken":    {"energy":  0, "days_to_escalate": 2, "escalates_to": ""},
	"exhausted": {"energy": -2, "days_to_escalate": 0, "escalates_to": ""},
	"starving":  {"energy": -2, "days_to_escalate": 0, "escalates_to": ""},
	"bleeding":  {"energy": -2, "days_to_escalate": 2, "escalates_to": "DEATH"},
	"fevered":   {"energy": -2, "days_to_escalate": 2, "escalates_to": "DEATH"},
}

var day := 1
var energy := 6
var energy_max := 6
var food := 70
var conditions: Dictionary = {}          ## id -> Tage
var days_at_zero_food := 0
var short_sleep_streak := 0              ## für "exhausted"
var run_active := true
var special_items_in_run: Array[String] = []
var ending := ""
var ending_detail := ""

## --- Tagesbudget -------------------------------------------------------------

## Berechnet die ENERGY für den kommenden Tag aus der letzten Nacht.
## segments: wie viele Schlaf-Segmente tatsächlich gezählt haben.
func compute_energy(segments: int, in_bed: bool, had_hot_meal: bool) -> int:
	var value := segments * 2
	if in_bed:
		value += 1
	if had_hot_meal:
		value += 1
	if food < 10:
		value -= 2
	elif food < 30:
		value -= 1
	for id in conditions:
		value += int(CONDITIONS.get(id, {}).get("energy", 0))
	return clampi(value, ENERGY_MIN, ENERGY_MAX)


func set_energy(value: int) -> void:
	energy_max = maxi(value, 1)
	energy = energy_max
	energy_changed.emit(energy, energy_max)


func can_spend(cost: int) -> bool:
	return run_active and energy >= cost


## Gibt Handlungen aus. Jede Handlung kostet zusätzlich FOOD.
func spend_action(cost: int = 1) -> bool:
	if not can_spend(cost):
		return false
	energy -= cost
	energy_changed.emit(energy, energy_max)
	add_food(-FOOD_PER_ACTION * cost)
	return true


## --- Hunger ------------------------------------------------------------------

func add_food(amount: int) -> void:
	food = clampi(food + amount, 0, FOOD_MAX)
	food_changed.emit(food)
	if food < 10:
		add_condition("starving")
	elif has_condition("starving"):
		remove_condition("starving")


## --- Zustände ----------------------------------------------------------------

func has_condition(id: String) -> bool:
	return conditions.has(id)


func add_condition(id: String) -> void:
	if conditions.has(id) or not CONDITIONS.has(id):
		return
	conditions[id] = 0
	condition_changed.emit(id, true)


func remove_condition(id: String) -> void:
	if not conditions.has(id):
		return
	conditions.erase(id)
	condition_changed.emit(id, false)


## Läuft einmal pro Tagwechsel: Zustände altern und eskalieren.
## Gibt die Meldungen zurück, die im Night Report auftauchen sollen.
func advance_conditions() -> Array[String]:
	var messages: Array[String] = []
	for id in conditions.keys():
		var spec: Dictionary = CONDITIONS[id]
		var limit := int(spec.get("days_to_escalate", 0))
		if limit <= 0:
			continue
		conditions[id] = int(conditions[id]) + 1
		if int(conditions[id]) < limit:
			continue
		var next: String = str(spec.get("escalates_to", ""))
		if next == "DEATH":
			end_run("DEATH", "%s went untreated." % id)
			return messages
		if next == "":
			remove_condition(id)
			messages.append("The %s has passed." % id)
		else:
			remove_condition(id)
			add_condition(next)
			messages.append("Your condition has worsened: %s." % next)
	return messages


## --- Tageswechsel ------------------------------------------------------------

func begin_new_day() -> Array[String]:
	day += 1
	day_changed.emit(day)
	add_food(-FOOD_PER_DAY)
	var messages := advance_conditions()
	if not run_active:
		return messages
	if food <= 0:
		days_at_zero_food += 1
		if days_at_zero_food >= 2:
			end_run("DEATH", "You starved.")
			return messages
	else:
		days_at_zero_food = 0
	if day >= RESCUE_DAY:
		end_run("RESCUE", "They found you.")
	return messages


func end_run(result: String, detail: String) -> void:
	if not run_active:
		return
	run_active = false
	ending = result
	ending_detail = detail
	run_ended.emit(result, detail)


func mystery_unlocked() -> bool:
	return day >= MYSTERY_UNLOCK_DAY


## Setzt alles auf Anfang. Es gibt bewusst KEIN Laden eines Spielstands —
## Permadeath ist der Modus, nicht eine Option.
func reset_run() -> void:
	day = 1
	food = 70
	conditions.clear()
	days_at_zero_food = 0
	short_sleep_streak = 0
	run_active = true
	ending = ""
	special_items_in_run.clear()
	set_energy(6)
	food_changed.emit(food)
	day_changed.emit(day)

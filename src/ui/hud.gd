extends Control
class_name AshHud
## Kopfzeile: Tag, ENERGY, FOOD, Raum, LIGHT, SAFETY, Zustände.
##
## ENERGY steht bewusst an erster Stelle — es ist der Wert, auf den der
## Spieler den ganzen Tag schaut.

var _day_label: Label
var _energy_label: Label
var _food_label: Label
var _room_label: Label
var _state_label: Label
var _condition_label: Label


func _ready() -> void:
	set_anchors_preset(Control.PRESET_TOP_WIDE)
	custom_minimum_size = Vector2(640, 40)
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	var bg := PanelContainer.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.add_theme_stylebox_override("panel", AshTheme.panel_style())
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)

	var rows := VBoxContainer.new()
	rows.add_theme_constant_override("separation", 2)
	bg.add_child(rows)

	var top := HBoxContainer.new()
	top.add_theme_constant_override("separation", 14)
	rows.add_child(top)
	_day_label = _make_label(top)
	_energy_label = _make_label(top)
	_food_label = _make_label(top)
	_condition_label = _make_label(top, true)

	var bottom := HBoxContainer.new()
	bottom.add_theme_constant_override("separation", 14)
	rows.add_child(bottom)
	_room_label = _make_label(bottom)
	_state_label = _make_label(bottom, true)

	GameState.energy_changed.connect(func(_a, _b): refresh())
	GameState.food_changed.connect(func(_a): refresh())
	GameState.day_changed.connect(func(_a): refresh())
	GameState.condition_changed.connect(func(_a, _b): refresh())
	Rooms.room_changed.connect(func(_a): refresh())
	Rooms.room_state_changed.connect(func(_a): refresh())
	refresh()


func _make_label(parent: Node, dim: bool = false) -> Label:
	var label := Label.new()
	AshTheme.apply_label(label, dim)
	parent.add_child(label)
	return label


func refresh() -> void:
	if _day_label == null:
		return
	_day_label.text = "DAY %d" % GameState.day
	_energy_label.text = "ENERGY %s" % _pips(GameState.energy, GameState.energy_max)
	_energy_label.add_theme_color_override("font_color",
		AshTheme.COLD if GameState.energy == 0 else AshTheme.WARM)
	_food_label.text = "FOOD %s" % _bar(GameState.food, GameState.FOOD_MAX)
	_food_label.add_theme_color_override("font_color",
		AshTheme.COLD if GameState.food < 30 else AshTheme.TEXT)

	var id := Rooms.current_id
	_room_label.text = Rooms.display_name(id).to_upper()
	_state_label.text = "light %s   safety %s" % [
		_pips(Rooms.light_of(id), 3), _pips(Rooms.safety_of(id), 3)]

	var conditions: Array = GameState.conditions.keys()
	_condition_label.text = "[%s]" % ", ".join(conditions) if not conditions.is_empty() else ""
	_condition_label.add_theme_color_override("font_color", AshTheme.COLD)


func _pips(value: int, maximum: int) -> String:
	var out := ""
	for i in maxi(maximum, 0):
		out += "*" if i < value else "."
	return out


func _bar(value: int, maximum: int) -> String:
	var filled := int(round(float(value) / float(maxi(maximum, 1)) * 8.0))
	var out := ""
	for i in 8:
		out += "#" if i < filled else "-"
	return out

extends Control
class_name RoomView
## Zeigt das Raumbild, die Hotspots und die Ausgänge.
##
## Pro Raum gibt es genau EIN Bild. Die vier LIGHT-Stufen entstehen als
## Tönung darüber — deshalb müssen die Raumbilder gleichmäßig ausgeleuchtet
## gezeichnet werden. Siehe docs/ASSET_PLAN.md.

signal hotspot_pressed(hotspot: Dictionary)
signal exit_pressed(room_id: String)

var _image: TextureRect
var _hotspot_layer: Control
var _exit_bar: HBoxContainer


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

	_image = TextureRect.new()
	_image.set_anchors_preset(Control.PRESET_FULL_RECT)
	_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	_image.stretch_mode = TextureRect.STRETCH_SCALE
	_image.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_image)

	_hotspot_layer = Control.new()
	_hotspot_layer.set_anchors_preset(Control.PRESET_FULL_RECT)
	_hotspot_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_hotspot_layer)

	_exit_bar = HBoxContainer.new()
	_exit_bar.position = Vector2(8, 296)
	_exit_bar.add_theme_constant_override("separation", 4)
	add_child(_exit_bar)

	Rooms.room_changed.connect(func(_id): refresh())
	Rooms.room_state_changed.connect(func(_id): refresh())


func refresh() -> void:
	var id := Rooms.current_id
	_load_image(id)
	_image.modulate = AshTheme.light_tint(Rooms.light_of(id))
	_build_hotspots(id)
	_build_exits(id)


func _load_image(id: String) -> void:
	var path := "res://assets/rooms/room_%s.png" % id
	if ResourceLoader.exists(path):
		_image.texture = load(path)
	else:
		_image.texture = null


func _build_hotspots(id: String) -> void:
	for child in _hotspot_layer.get_children():
		child.queue_free()
	for spot in Rooms.hotspots(id):
		var rect: Array = spot.get("rect", [0, 0, 40, 40])
		var button := Button.new()
		button.position = Vector2(float(rect[0]), float(rect[1]))
		button.size = Vector2(float(rect[2]), float(rect[3]))
		button.text = ""
		button.tooltip_text = str(spot.get("name", ""))
		button.flat = true
		button.add_theme_stylebox_override("normal", _hotspot_style(AshTheme.HOTSPOT, false))
		button.add_theme_stylebox_override("hover", _hotspot_style(AshTheme.HOTSPOT, true))
		button.add_theme_stylebox_override("pressed", _hotspot_style(AshTheme.HOTSPOT, true))
		button.add_theme_stylebox_override("focus", _hotspot_style(AshTheme.HOTSPOT, true))
		button.pressed.connect(func(): hotspot_pressed.emit(spot))
		_hotspot_layer.add_child(button)

		var label := Label.new()
		label.text = str(spot.get("name", ""))
		label.position = button.position + Vector2(2, button.size.y - 12)
		AshTheme.apply_label(label, true)
		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_hotspot_layer.add_child(label)


func _hotspot_style(fill: Color, highlight: bool) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = fill
	s.border_color = AshTheme.HOTSPOT_HOVER if highlight else Color(1, 1, 1, 0.18)
	s.set_border_width_all(1)
	return s


func _build_exits(id: String) -> void:
	for child in _exit_bar.get_children():
		child.queue_free()
	for target in Rooms.exits(id):
		var button := Button.new()
		button.text = "> " + Rooms.display_name(str(target))
		AshTheme.apply_button(button)
		button.pressed.connect(func(): exit_pressed.emit(str(target)))
		_exit_bar.add_child(button)

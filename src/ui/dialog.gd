extends PanelContainer
class_name AshDialog
## Ein Dialog für alles: Aktionsmenü, Ereignis, Schlaf, Night Report.
##
## Die Kosten stehen bei jeder Option im Text — der Spieler soll informiert
## entscheiden, nicht raten. Siehe docs/GAME_DESIGN.md Abschnitt 9.

signal choice_made(index: int)
signal dismissed()

var _title: Label
var _body: RichTextLabel
var _buttons: VBoxContainer


func _ready() -> void:
	add_theme_stylebox_override("panel", AshTheme.panel_style(AshTheme.WARM))
	custom_minimum_size = Vector2(420, 0)

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 6)
	add_child(box)

	_title = Label.new()
	AshTheme.apply_label(_title)
	_title.add_theme_color_override("font_color", AshTheme.WARM)
	box.add_child(_title)

	_body = RichTextLabel.new()
	_body.bbcode_enabled = false
	_body.fit_content = true
	_body.scroll_active = false
	_body.custom_minimum_size = Vector2(400, 0)
	_body.add_theme_color_override("default_color", AshTheme.TEXT)
	_body.add_theme_font_size_override("normal_font_size", 10)
	box.add_child(_body)

	_buttons = VBoxContainer.new()
	_buttons.add_theme_constant_override("separation", 3)
	box.add_child(_buttons)


## options: Array von {label: String, enabled: bool, hint: String}
func show_dialog(title: String, body: String, options: Array) -> void:
	_title.text = title.to_upper()
	_body.text = body
	for child in _buttons.get_children():
		child.queue_free()
	for i in options.size():
		var option: Dictionary = options[i]
		var button := Button.new()
		var hint := str(option.get("hint", ""))
		button.text = str(option.get("label", "…")) + ("   — " + hint if hint != "" else "")
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		AshTheme.apply_button(button)
		button.disabled = not bool(option.get("enabled", true))
		var index := i
		button.pressed.connect(func(): choice_made.emit(index))
		_buttons.add_child(button)
	visible = true
	if not _buttons.get_children().is_empty():
		(_buttons.get_child(0) as Button).grab_focus()


func close() -> void:
	visible = false
	dismissed.emit()

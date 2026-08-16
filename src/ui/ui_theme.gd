extends RefCounted
class_name AshTheme
## Farben und Stile an einem Ort.
##
## Kein reines Schwarz und kein reines Weiß — die Palette liegt leicht
## ins Blaugrüne, damit Kerzenlicht als Wärme lesbar wird.
## Siehe docs/ASSET_PLAN.md Abschnitt 1.

const INK := Color("0b0e10")          # Grund, fast schwarz mit Blaustich
const PANEL := Color("15191c")
const PANEL_EDGE := Color("2a3136")
const TEXT := Color("c8c4b8")         # Staubweiß, nie reines Weiß
const TEXT_DIM := Color("6f7773")
const WARM := Color("d8a24a")         # Kerzenlicht = Sicherheit
const COLD := Color("8c4038")         # stumpfes Rot = Gefahr
const HOTSPOT := Color(1, 1, 1, 0.10)
const HOTSPOT_HOVER := Color("d8a24a")


static func panel_style(border: Color = PANEL_EDGE) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = PANEL
	s.border_color = border
	s.set_border_width_all(1)
	s.set_content_margin_all(8)
	return s


static func button_style(bg: Color, border: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = bg
	s.border_color = border
	s.set_border_width_all(1)
	s.set_content_margin_all(4)
	return s


static func apply_button(button: Button) -> void:
	button.add_theme_stylebox_override("normal", button_style(PANEL, PANEL_EDGE))
	button.add_theme_stylebox_override("hover", button_style(PANEL_EDGE, WARM))
	button.add_theme_stylebox_override("pressed", button_style(PANEL_EDGE, WARM))
	button.add_theme_stylebox_override("disabled", button_style(PANEL, PANEL))
	button.add_theme_stylebox_override("focus", button_style(PANEL_EDGE, WARM))
	button.add_theme_color_override("font_color", TEXT)
	button.add_theme_color_override("font_hover_color", WARM)
	button.add_theme_color_override("font_disabled_color", TEXT_DIM)
	button.add_theme_font_size_override("font_size", 10)


static func apply_label(label: Label, dim: bool = false) -> void:
	label.add_theme_color_override("font_color", TEXT_DIM if dim else TEXT)
	label.add_theme_font_size_override("font_size", 10)


## Wie stark das Raumbild gedimmt wird.
##
## Stufe 0 war ursprünglich 0.16 — zusammen mit dunkel gezeichneten Räumen
## ergab das ein komplett schwarzes Bild. Dunkelheit muss unangenehm sein,
## nicht unsichtbar: man soll Umrisse erkennen und trotzdem merken, dass
## man Licht braucht.
static func light_tint(level: int) -> Color:
	match level:
		0: return Color(0.42, 0.45, 0.52, 1.0)
		1: return Color(0.68, 0.69, 0.72, 1.0)
		2: return Color(0.92, 0.84, 0.70, 1.0)
		_: return Color(1.0, 0.98, 0.92, 1.0)

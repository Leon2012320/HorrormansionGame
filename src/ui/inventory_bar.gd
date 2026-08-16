extends Control
class_name AshInventoryBar
## Die sechs getragenen Plätze, unten rechts.
##
## Zeigt die Icons aus assets/items/<id>.png. Fehlt eine Datei, wird der
## Platz mit den ersten zwei Buchstaben beschriftet — das Spiel bleibt also
## spielbar, auch wenn noch nichts gezeichnet ist.

const SLOT := 34
const GAP := 2

var _slots: Array[Control] = []


func _ready() -> void:
	custom_minimum_size = Vector2(Inventory.CARRY_SLOTS * (SLOT + GAP), SLOT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	for i in Inventory.CARRY_SLOTS:
		var slot := Control.new()
		slot.position = Vector2(i * (SLOT + GAP), 0)
		slot.custom_minimum_size = Vector2(SLOT, SLOT)
		slot.size = Vector2(SLOT, SLOT)
		slot.mouse_filter = Control.MOUSE_FILTER_IGNORE
		add_child(slot)
		_slots.append(slot)

	Inventory.carried_changed.connect(refresh)
	refresh()


func refresh() -> void:
	# Getragenes in eine flache Liste von Slots übersetzen.
	var entries: Array = []
	for id in Inventory.carried:
		if Inventory.is_weightless(str(id)):
			continue
		var per_slot := maxi(Inventory.stack_size(str(id)), 1)
		var left := int(Inventory.carried[id])
		while left > 0 and entries.size() < Inventory.CARRY_SLOTS:
			entries.append({"id": str(id), "count": mini(left, per_slot)})
			left -= per_slot

	for i in _slots.size():
		var slot := _slots[i]
		for child in slot.get_children():
			child.queue_free()
		_draw_slot(slot, entries[i] if i < entries.size() else {})


func _draw_slot(slot: Control, entry: Dictionary) -> void:
	var frame := Panel.new()
	frame.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	frame.add_theme_stylebox_override("panel",
		AshTheme.button_style(AshTheme.PANEL, AshTheme.WARM if not entry.is_empty() else AshTheme.PANEL_EDGE))
	frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	slot.add_child(frame)
	if entry.is_empty():
		return

	var id := str(entry["id"])
	var path := "res://assets/items/%s.png" % id
	if ResourceLoader.exists(path):
		var icon := TextureRect.new()
		icon.texture = load(path)
		icon.position = Vector2(1, 1)
		icon.size = Vector2(SLOT - 2, SLOT - 2)
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
		slot.add_child(icon)
	else:
		var initials := Label.new()
		initials.text = Inventory.display_name(id).substr(0, 2).to_upper()
		initials.position = Vector2(4, 8)
		AshTheme.apply_label(initials)
		initials.mouse_filter = Control.MOUSE_FILTER_IGNORE
		slot.add_child(initials)

	if int(entry["count"]) > 1:
		var count := Label.new()
		count.text = str(int(entry["count"]))
		count.position = Vector2(SLOT - 13, SLOT - 15)
		AshTheme.apply_label(count)
		count.add_theme_color_override("font_color", AshTheme.WARM)
		count.mouse_filter = Control.MOUSE_FILTER_IGNORE
		slot.add_child(count)

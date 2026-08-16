extends Node
## Startet das Spiel unter Xvfb und legt nach ein paar Frames ein Bild ab.
##
##     xvfb-run -a godot --rendering-driver opengl3 tools/screenshot.tscn

var _frames := 0

func _ready() -> void:
	var path := "res://assets/rooms/room_entrance.png"
	print("exists: %s" % ResourceLoader.exists(path))
	var tex := load(path)
	print("loaded: %s  size: %s" % [tex != null, str(tex.get_size()) if tex else "-"])
	var game: Node = load("res://src/scenes/main.tscn").instantiate()
	add_child(game)

func _process(_delta: float) -> void:
	_frames += 1
	if _frames == 10:
		var view: Node = get_node_or_null("Main")
		if view and view.get("room_view"):
			var rv = view.room_view
			print("room_view size: %s" % str(rv.size))
			for child in rv.get_children():
				if child is TextureRect:
					print("  TextureRect size=%s tex=%s modulate=%s" % [
						str(child.size), str(child.texture != null), str(child.modulate)])
	if _frames < 20:
		return
	get_viewport().get_texture().get_image().save_png("res://screenshot.png")
	print("screenshot saved")
	get_tree().quit()

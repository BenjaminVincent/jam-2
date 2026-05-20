extends Control


func _ready() -> void:
	print("READY!")

func _on_gui_input(event: InputEvent) -> void:
	print("test: ", event)
	if event.is_action_just_pressed("FULLSCREEN"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

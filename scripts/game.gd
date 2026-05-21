extends Node2D
@onready var current_level: Node2D = $CurrentLevel


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("FULLSCREEN"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)



func _ready() -> void:
	match GameState.current_level:
		1:
			print("loading level: ", GameState.current_level)
			current_level.add_child(load("res://scenes/board_standard.tscn").instantiate())
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass

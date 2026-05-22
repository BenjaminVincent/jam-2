extends Node2D
@onready var current_level: Node2D = $CurrentLevel
@onready var score: RichTextLabel = $CanvasLayer/Score



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("FULLSCREEN"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)



func _ready() -> void:
	_load_level()
	GameState.update_score.connect(_on_update_score)



func _on_button_pressed(source: BaseButton) -> void:
	
	if "1" in source.name:
		GameState.current_level = 1
	elif "2" in source.name:
		GameState.current_level = 2
	elif "3" in source.name:
		GameState.current_level = 3
	else:
		print("level not found")
	
	_load_level(GameState.current_level)



func _load_level(_current_level = null) -> void:
	
	for child in current_level.get_children():
		child.queue_free()
	
	var level_path = ("res://scenes/levels/level_" + str(_current_level) + ".tscn")
	
	var level
	if ResourceLoader.exists(level_path):
		level = load(level_path)
	else:
		level = load("res://scenes/levels/level_default.tscn")
	
	current_level.add_child(level.instantiate())



func _on_update_score() -> void:
	score.text = "SCORE: " + str(GameState.score)

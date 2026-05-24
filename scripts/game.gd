extends Node2D

@onready var current_level_container: Node2D = $CurrentLevelContainer
@onready var score: RichTextLabel = $CanvasLayer/Score
@onready var remaining: RichTextLabel = $CanvasLayer/Remaining
@onready var required_level_score: RichTextLabel = $CanvasLayer/RequiredLevelScore


func _ready() -> void:
	GameState.update_score.connect(_on_update_score)
	GameState.update_ball_count.connect(_on_update_ball_count)
	GameState.update_required_level_score.connect(_on_update_required_level_score)
	#GameState.load_next_level.connect(_on_load_next_level)
	_load_level(1)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("FULLSCREEN"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)




func _on_button_pressed(source: BaseButton) -> void:
	
	if "1" in source.name:
		GameState.current_level_DEBUG = 1
	elif "2" in source.name:
		GameState.current_level_DEBUG = 2
	elif "3" in source.name:
		GameState.current_level_DEBUG = 3
	elif "4" in source.name:
		GameState.current_level_DEBUG = 4
	else:
		print("level not found")
	GameState.current_level = GameState.current_level_DEBUG
	_load_level(GameState.current_level_DEBUG)



func _load_level(_current_level = null) -> void:
	print("TOP OF _load_level: ", _current_level)
	for child in current_level_container.get_children():
		if child: child.queue_free()
	
	var level_path = ("res://scenes/levels/level_" + str(_current_level) + ".tscn")
	var level
	
	if ResourceLoader.exists(level_path):
		level = load(level_path)
	else:
		print("LOADING DEFAULT LEVEL")
		level = load("res://scenes/levels/level_default.tscn")
	
	current_level_container.add_child(level.instantiate())
	
	GameState.on_going = true
	print("_load_level GameState.on_going: ", GameState.on_going)


func _on_update_score() -> void:
	score.text = "SCORE: " + str(GameState.score)



func _on_update_ball_count() -> void:
	remaining.text = "REMAINING: " + str(GameState.remaining_balls)



func _on_update_required_level_score() -> void:
	required_level_score.text = "REQUIRED: " + str(GameState.required_level_score)



func _on_load_next_level() -> void: 
	print("current_level: ", GameState.current_level)
	await get_tree().create_timer(3).timeout
	await get_tree().process_frame
	GameState._reset_game()
	_load_level(GameState.current_level)
	

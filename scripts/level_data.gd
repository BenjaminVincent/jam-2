extends Node

@export var ball_limit: int = 3
@export var required_score: int = 100
@export var launcher_speed_auto: float = 1.5

func _ready() -> void:
	GameState.set_remaining_balls(ball_limit)
	GameState.set_required_level_score(required_score)
	GameState.set_launcher_speed(launcher_speed_auto)

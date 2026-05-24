extends Node

@export var ball_limit: int = 3



func _ready() -> void:
	GameState.set_remaining_balls(ball_limit)

extends Node

var current_level: int = 1
var score: int = 0

signal update_score



func add_to_score(points) -> void:
	score += points
	emit_signal("update_score")



func _reset_game() -> void:
	
	var player = get_node_or_null("/root/Game/Player")
	
	if player:
		player._reset_ball()
		GameState.score = 0
		emit_signal("update_score")
	else:
		push_error("Player was not found, unable to reset game")

extends Node

var current_level: int = 1
var score: int = 0
var remaining_balls: int = 0
var required_level_score: int = 0

signal update_score
signal update_ball_count
signal update_required_level_score


func add_to_score(_score) -> void:
	score += _score
	emit_signal("update_score")



func set_remaining_balls(_count) -> void:
	remaining_balls = _count
	emit_signal("update_ball_count")



func set_required_level_score(_score) -> void:
	required_level_score = _score
	emit_signal("update_required_level_score")



func _reset_game() -> void:
	
	GameState.score = 0
	
	emit_signal("update_score")
	
	var game = get_node_or_null("/root/Game/")
	
	for object in game.get_children():
		if object.has_meta("type") and object.get_meta("type") == "ball":
			object.queue_free()



func _round_over() -> void:
	pass

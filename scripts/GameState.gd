extends Node

var current_level: int = 1
var current_level_DEBUG: int = 1
var score: int = 0
var remaining_balls: int = 0
var required_level_score: int = 0
var max_level: int = 4
var launcher_speed: float = 1.5
var launcher_strength: int = 10

signal update_score
signal update_ball_count
signal update_required_level_score
signal update_launcher_speed
signal update_launcher_strength
signal load_next_level


func add_to_score(_score) -> void:
	score += _score
	emit_signal("update_score")
	
	if score >= required_level_score and current_level <= max_level:
		print("YOU HAVE COMPLETED LEVEL: ", current_level)
		current_level += 1
		emit_signal("load_next_level")



func set_remaining_balls(_count) -> void:
	remaining_balls = _count
	emit_signal("update_ball_count")



func set_required_level_score(_score) -> void:
	required_level_score = _score
	emit_signal("update_required_level_score")


func set_launcher_speed(_speed) -> void:
	launcher_speed = _speed
	emit_signal("update_launcher_speed")


func set_launcher_strength(_strength) -> void:
	launcher_strength = _strength
	emit_signal("update_launcher_strength")


func _reset_game() -> void:
	
	GameState.score = 0
	
	emit_signal("update_score")
	
	var game = get_node_or_null("/root/Game/")
	
	for object in game.get_children():
		if object.has_meta("type") and object.get_meta("type") == "ball":
			object.queue_free()



func _round_over() -> void:
	pass

extends Node

var current_level: int = 1
var score: int = 0

signal update_score



func add_to_score(points) -> void:
	score += points
	emit_signal("update_score")



func _reset_game() -> void:
	
	GameState.score = 0
	
	emit_signal("update_score")
	
	var game = get_node_or_null("/root/Game/")
	
	for object in game.get_children():
		if object.has_meta("type") and object.get_meta("type") == "ball":
			object.queue_free()



func _round_over() -> void:
	pass

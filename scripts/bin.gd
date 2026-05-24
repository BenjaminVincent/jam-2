@tool
extends StaticBody2D

@export var point_value: int = 5:
	set(value):
		point_value = value
		_update_label()

@onready var score_label: RichTextLabel = $ScoreLabel



func _ready() -> void:
	_update_label()
	set_meta("type", "bin")
	score_label.text = str(point_value)



func _update_label() -> void:
	if is_node_ready() and score_label:
		score_label.text = str(point_value)



func _on_hit() -> void:
	GameState.add_to_score(point_value)
	print("adding points!")

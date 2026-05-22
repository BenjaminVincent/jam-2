extends StaticBody2D

@onready var score_label: RichTextLabel = $ScoreLabel
@export var point_value: int = 5


func _ready() -> void:
	set_meta("type", "bin")
	score_label.text = str(point_value)



func _on_hit() -> void:
	GameState.add_to_score(point_value)

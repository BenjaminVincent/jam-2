extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var point_value: int = 0
@export var bounciness: float = 1.0

var hit_texture = load("res://assets/peg_hit.png")
var base_texture = load("res://assets/peg.png")



func _ready() -> void:
	set_meta("type", "collider")


func get_bounciness() -> float:
	return bounciness


func _on_hit() -> void:
	audio_stream_player.play()
	
	GameState.add_to_score(point_value)
	
	if point_value > 0:
		var display_number = load("res://scenes/display_number.tscn").instantiate()
		display_number.get_node("RichTextLabel").text = str(point_value)
		add_child(display_number)
		tween_number(display_number)
	
	
	sprite_2d.texture = hit_texture
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	sprite_2d.texture = base_texture


func tween_number(node) -> void:
	var tween = create_tween()
	tween.tween_property(node, "scale", Vector2(2, 2), 0.6).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(node, "position", Vector2(0, -64), 1.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.6)
	tween.tween_property(node, "scale", Vector2(1, 1), 0.3).set_trans(Tween.TRANS_SINE)
	tween.tween_property(node, "modulate:a", 0.0, 0.5)
	await tween.finished
	node.queue_free()

extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var hit_texture = load("res://assets/peg_hit.png")
var base_texture = load("res://assets/peg.png")

func _ready() -> void:
	set_meta("type", "collider")

func _on_hit() -> void:
	sprite_2d.texture = hit_texture
	await get_tree().create_timer(0.3).timeout
	await get_tree().process_frame
	sprite_2d.texture = base_texture

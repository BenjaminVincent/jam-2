extends RigidBody2D

var initial_position: Vector2
var current_bin: StaticBody2D
var stop_threshold: float = 0.05

@onready var game = get_node("/root/Game")

func _ready() -> void:
	set_meta("type", "ball")
	freeze = true
	initial_position = position



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("RESET_GAME"):
		GameState._reset_game()
		pass
		
	if Input.is_action_just_pressed("LAUNCH"):
		freeze = false



func _on_body_entered(body: Node) -> void:
	if body.has_meta("type") and body.get_meta("type") == "collider":
		body._on_hit()
	if body.has_meta("type") and body.get_meta("type") == "bin":
		current_bin = body



func _on_sleeping_state_changed() -> void:
	if sleeping and current_bin:
		current_bin._on_hit()
		current_bin = null
		queue_free()
	  

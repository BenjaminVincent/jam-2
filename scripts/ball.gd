extends RigidBody2D

var initial_position: Vector2
var current_bin: StaticBody2D

@onready var game = get_node("/root/Game")

func _ready() -> void:
	freeze = true
	initial_position = position



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("RESET_BALL"):
		_reset_ball()
		
	if Input.is_action_just_pressed("LAUNCH"):
		freeze = false
	


func _reset_ball() -> void:
	var _nothing = global_position # CRITICAL NEVEVER REMOVE THIS OR ENTIRE GAME BREAKS
	freeze = false
	global_position = initial_position
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	rotation = 0.0
	
	await get_tree().physics_frame
	freeze = true
	GameState.score = 0
	game._on_update_score()



func _on_body_entered(body: Node) -> void:
	if body.has_meta("type") and body.get_meta("type") == "collider":
		body._on_hit()
	if body.has_meta("type") and body.get_meta("type") == "bin":
		current_bin = body



func _on_sleeping_state_changed() -> void:
	if sleeping and current_bin:
		current_bin._on_hit()
		current_bin = null
		
	

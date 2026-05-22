extends RigidBody2D

var initial_position: Vector2
var current_bin: StaticBody2D

func _ready() -> void:
	freeze = true
	initial_position = position



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("RESET_BALL"):
		#_reset_ball(initial_position)
		GameState._reset_game()
		
	if Input.is_action_just_pressed("LAUNCH"):
		freeze = false
	


func _reset_ball(spawn_pos: Vector2 = initial_position) -> void:
	freeze = false
	var _transform := Transform2D(0.0, spawn_pos)
	PhysicsServer2D.body_set_state(get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, _transform)
	PhysicsServer2D.body_set_state(get_rid(), PhysicsServer2D.BODY_STATE_LINEAR_VELOCITY, Vector2.ZERO)
	PhysicsServer2D.body_set_state(get_rid(), PhysicsServer2D.BODY_STATE_ANGULAR_VELOCITY, 0.0)
	freeze = true


func _on_body_entered(body: Node) -> void:
	#print("sleeping: ", sleeping)
	#print("body: ", body)
	if body.has_meta("type") and body.get_meta("type") == "collider":
		body._on_hit()
	if body.has_meta("type") and body.get_meta("type") == "bin":
		current_bin = body


func _on_sleeping_state_changed() -> void:
	if current_bin:
		current_bin._on_hit()
	

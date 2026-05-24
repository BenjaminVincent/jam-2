extends CharacterBody2D


const ROTATION_SPEED = 1.5
const ANGLE_LIMIT = 60
const LAUNCH_SPEED = 15

var direction = 1

@export var automatic: bool = true


func _physics_process(_delta: float) -> void:
	var _min = deg_to_rad(-ANGLE_LIMIT)
	var _max = deg_to_rad(ANGLE_LIMIT)
	
	if automatic:
		if rotation <= _min or rotation >= _max:
			direction *= -1
	else:
		direction = -Input.get_axis("ui_left", "ui_right")
	
	rotation += direction * ROTATION_SPEED * _delta
	rotation = clamp(rotation, _min, _max)
	
	
	move_and_slide()



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LAUNCH"):
		var active_ball = _check_active_ball()
		
		if active_ball: return
		
		if GameState.remaining_balls <= 0: return
		
		GameState.set_remaining_balls(GameState.remaining_balls - 1)
		
		var game = get_node("/root/Game")
		var ball = load("res://scenes/ball.tscn").instantiate()
		var direction = Vector2.DOWN.rotated(global_rotation)
		
		direction = Vector2(rad_to_deg(direction.x), rad_to_deg(direction.y))
		
		ball.global_position = global_position
		game.add_child(ball)
		
		ball.linear_velocity = direction * LAUNCH_SPEED



func _check_active_ball() -> bool:
	var game = get_node_or_null("/root/Game/")
	for object in game.get_children():
		if object.has_meta("type") and object.get_meta("type") == "ball":
			return true
	return false

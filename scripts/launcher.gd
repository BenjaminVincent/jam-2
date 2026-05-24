extends CharacterBody2D


const ROTATION_SPEED_TEST = 1.5
const ANGLE_LIMIT = 60
const LAUNCH_SPEED = 15

var direction = 1
var rotation_speed_auto = ROTATION_SPEED_TEST
var _min = deg_to_rad(-ANGLE_LIMIT)
var _max = deg_to_rad(ANGLE_LIMIT)

@export var automatic: bool = true


func _physics_process(_delta: float) -> void:
	if automatic:
		if rotation <= _min or rotation >= _max:
			direction *= -1
			
		rotation += direction * rotation_speed_auto * _delta
		
	else:
		direction = -Input.get_axis("ui_left", "ui_right")
		rotation += direction * ROTATION_SPEED_TEST * _delta
	
	rotation = clamp(rotation, _min, _max)
	
	move_and_slide()



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LAUNCH"):
		if GameState.score >= GameState.required_level_score: return
		
		var active_ball = _check_active_ball()
		
		if active_ball: return
		
		if GameState.remaining_balls <= 0: return
		
		GameState.set_remaining_balls(GameState.remaining_balls - 1)
		
		var game = get_node("/root/Game")
		var ball = load("res://scenes/ball.tscn").instantiate()
		var angle = Vector2.DOWN.rotated(global_rotation)
		
		angle = Vector2(rad_to_deg(angle.x), rad_to_deg(angle.y))
		
		ball.global_position = global_position
		game.add_child(ball)
		
		ball.linear_velocity = angle * LAUNCH_SPEED



func _check_active_ball() -> bool:
	var game = get_node_or_null("/root/Game/")
	for object in game.get_children():
		if object.has_meta("type") and object.get_meta("type") == "ball":
			return true
	return false

extends CharacterBody2D


const ROTATION_SPEED = 1.5
const ANGLE_LIMIT = 60
const LAUNCH_SPEED = 15


func _physics_process(_delta: float) -> void:
	
	var direction := Input.get_axis("ui_left", "ui_right")
	rotation += -direction * ROTATION_SPEED * _delta
	
	var _min = deg_to_rad(-ANGLE_LIMIT)
	var _max = deg_to_rad(ANGLE_LIMIT)
	rotation = clamp(rotation, _min, _max)
	
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("LAUNCH"):
		
		var game = get_node("/root/Game")
		var ball = load("res://scenes/ball.tscn").instantiate()
		var direction = Vector2.DOWN.rotated(global_rotation)
		direction = Vector2(rad_to_deg(direction.x), rad_to_deg(direction.y))
		
		print("direction ", direction)
		
		ball.global_position = global_position
		game.add_child(ball)
		
		ball.linear_velocity = direction * LAUNCH_SPEED
		

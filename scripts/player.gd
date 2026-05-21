extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const LAUNCH_BOOST = 1.5

const LAUNCH_FRICTION: = 0.99
const START_FRICTION: = 0.70
const ELASTICITY: float = 0.85

const GRAVITY: Vector2 = Vector2(0.0, 2100.0)

var launched: bool = false
var just_launched: bool = false

var allow_input = true



func _ready() -> void:
	position.x = get_viewport_rect().size.x / 2.0



func _physics_process(delta: float) -> void:

	if launched:
		velocity += GRAVITY * delta
	
	if just_launched:
		velocity.x *= LAUNCH_BOOST
		just_launched = false
		allow_input = false

	# NOTICE MOVING 
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction and not launched:
		velocity.x = direction * SPEED
	else:
		if launched:
			velocity.x = move_toward(velocity.x, velocity.x * LAUNCH_FRICTION, SPEED)
		else:
			velocity.x = move_toward(velocity.x, velocity.x * START_FRICTION, SPEED)
	
	var collision = move_and_collide(velocity * delta)

	# NOTICE BOUNCING
	if collision and launched:

		velocity = velocity.bounce(collision.get_normal())
		velocity = Vector2(velocity.x * ELASTICITY, velocity.y * ELASTICITY)

		if collision.get_collider().has_meta("type") and collision.get_collider().get_meta("type") == "collider":
			var other = collision.get_collider()
			other._on_hit()
		
		
	if Input.is_action_just_pressed("RESET_BALL"):
		_reset_ball()
	if Input.is_action_just_pressed("RESET_GAME"):
		GameState._reset_game()



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LAUNCH") and allow_input:
		launched = true
		just_launched = true



func _reset_ball() -> void:
	position = Vector2(get_viewport_rect().size.x / 2.0, 0.0)
	velocity = Vector2(0.0, 0.0)
	launched = false
	just_launched = false
	allow_input = true

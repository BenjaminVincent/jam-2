extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const LAUNCH_BOOST = 1.5

const LAUNCH_FRICTION: = 0.99
const START_FRICTION: = 0.70
const ELASTICITY: float = 0.70

var launched: bool = false
var just_launched: bool = false

func _ready() -> void:
	print("player is ready")
	position.x = get_viewport_rect().size.x / 2.0



func _physics_process(delta: float) -> void:

	if not is_on_floor() and launched:
		velocity += get_gravity() * delta
	
	if just_launched:
		velocity.x *= LAUNCH_BOOST
		just_launched = false

	# NOTICE JUMPING
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
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



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LAUNCH"):
		launched = true
		just_launched = true
		

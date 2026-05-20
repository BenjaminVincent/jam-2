extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var launched: bool = false

func _ready() -> void:
	print("player is ready")
	position.x = get_viewport_rect().size.x / 2.0



func _physics_process(delta: float) -> void:

	if not is_on_floor() and launched:
		velocity += get_gravity() * delta
	
	
	# NOTICE JUMPING
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# NOTICE MOVING 
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction and not launched:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, velocity.x * 0.9, SPEED)
	
	var collision = move_and_collide(velocity * delta)

	# NOTICE BOUNCING
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		velocity = Vector2(velocity.x * 0.75, velocity.y * 0.75)



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LAUNCH"):
		launched = true

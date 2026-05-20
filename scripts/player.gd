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

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LAUNCH"):
		launched = true

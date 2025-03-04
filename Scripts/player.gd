extends CharacterBody2D


const SPEED:float = 420.0
const JUMP_VELOCITY:float = -520.0
const SLIDE_FACTOR:float = 0.2
const DASH_FACTOR:float = 10.0
const JUMP_DEGRADE:float = 4.0
var can_dash:bool = true
var speed_mod:float = 0.0
var HeightTimer:float = 0.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		$JumpBuffer.start()
	if $JumpBuffer.time_left > 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y /= JUMP_DEGRADE
	
	# Handle dash
	if Input.is_action_just_pressed("dash") and can_dash and not is_on_floor():
		velocity.x *= DASH_FACTOR
		can_dash = false
	if is_on_floor():
		can_dash = true
	
	# Handle run
	if Input.is_action_pressed("dash"):
		$Sprite2D.get_material().set_shader_parameter("hit_effect", 0.1)
		speed_mod = 100
	elif not Input.is_action_just_pressed("dash"):
		$Sprite2D.get_material().set_shader_parameter("hit_effect", 0.0)
		speed_mod = 0

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite based on direction
	if direction == -1:
		$Sprite2D.set_flip_h(false)
	elif direction == 1:
		$Sprite2D.set_flip_h(true)
	
	if direction:
		velocity.x = lerp(velocity.x, direction * (SPEED + speed_mod), SLIDE_FACTOR)
	else:
		velocity.x = lerp(velocity.x, 0.0, SLIDE_FACTOR)

	move_and_slide()

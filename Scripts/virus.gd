extends CharacterBody2D

const SPEED:float = 100.0
var direction:int = -1

signal body_entered(body: Node2D)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_wall():
		direction *= -1
	velocity.x = SPEED * direction
	move_and_slide()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("body", body)
	direction *= -1
	$AnimatedSprite2D.flip_h = false if direction == -1 else true
	body_entered.emit(body)

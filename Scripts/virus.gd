extends CharacterBody2D

@export var SPEED:float = 100.0
var direction:int = -1
var can_move:bool = false

signal body_entered(body: Node2D)

func _physics_process(delta: float) -> void:
	if can_move:
		if not is_on_floor():
			velocity += get_gravity() * delta
		if is_on_wall():
			direction *= -1
		velocity.x = SPEED * direction
		move_and_slide()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	direction *= -1
	$AnimatedSprite2D.flip_h = false if direction == -1 else true
	body_entered.emit(body)


func _on_wakebox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_move = true
		$AnimatedSprite2D.play()


func _on_wakebox_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_move = false
		$AnimatedSprite2D.pause()

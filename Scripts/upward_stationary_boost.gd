extends Area2D

const BOOST_FACTOR:float = -800.0

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.y = 0
		body.velocity.y += BOOST_FACTOR

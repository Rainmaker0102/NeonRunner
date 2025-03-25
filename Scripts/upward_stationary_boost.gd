extends Area2D

const BOOST_SPEED:float = -400.0

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.position.y += BOOST_SPEED

extends Node2D

var next_level = preload("res://Levels/pink_level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_death_barrier_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		$Player.set_position(Vector2(384,592))


func _on_load_wait_timeout() -> void:
	$Player/Camera2D.set_position_smoothing_enabled(true)


func _on_level_door_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_packed(next_level)

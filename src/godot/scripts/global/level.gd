extends Node2D

@export var next_scn_left:String
@export var next_scn_right:String
"""
func _on_exit_left_body_entered(_body: Node2D) -> void:
	var next_scn=load(next_scn_left)
	var next_scn_instance=next_scn.instantiate()
	next_scn_instance.init_player_position(Vector2.LEFT)
	get_tree().root.call_deferred("add_child",next_scn_instance)
	queue_free()

"""
func _on_exit_right_body_entered(_body: Node2D):
	var next_scn=load(next_scn_right)
	var next_scn_instance=next_scn.instantiate()
	next_scn_instance.init_player_position(Vector2.RIGHT)
	get_tree().root.call_deferred("add_child",next_scn_instance)
	queue_free()
"""
func init_player_position(direction: Vector2):
	if direction == Vector2.RIGHT:
		$"global_node/Fuyu".position = $SpawnerLeft.position
	elif direction == Vector2.LEFT:
		$"global_node/Fuyu".position = $SpawnerRight.position
"""

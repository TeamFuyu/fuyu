extends VBoxContainer


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

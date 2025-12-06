extends Control

func _on_retry_pressed():
	global.current_health = global.max_health
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn") #va être globalisé

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/index.tscn")

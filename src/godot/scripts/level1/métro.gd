extends AnimatedSprite2D
@onready var player = get_node("../global_node/Fuyu")
@onready var PORTEE = 300
@onready var DECALAGE_X = -200
@onready var DECALAGE_Y = -10
@onready var ap = $"."

func _process(_delta):
	if portée($".") :
		ap.play("open_door")
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
		if frame==8:
			ap.pause()
		
		#if Input.is_action_just_pressed("interact"):
			#get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
		else:
			ap.play()
	else :
		if frame !=0:
			ap.play_backwards("open_door")
		else:
			ap.play("default")
		
func portée(personnage)->bool:
	return int(player.position.x) > personnage.position.x-PORTEE+DECALAGE_X and int(player.position.x) < personnage.position.x+PORTEE+DECALAGE_X and int(player.position.y) > personnage.position.y-PORTEE+DECALAGE_Y and int(player.position.y) < personnage.position.y+PORTEE+DECALAGE_Y 

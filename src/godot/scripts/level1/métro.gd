extends AnimatedSprite2D
@onready var player = get_node("../global_node/Fuyu")
@onready var PORTEE = 300
@onready var DECALAGE_X = -200
@onready var DECALAGE_Y = -10
@onready var ap = $"."

func _process(_delta):
	if global.portée(player,$".",PORTEE,DECALAGE_X,DECALAGE_Y) :
		ap.play("open_door")
		global.help_box="SHIFT pour monter !"
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
			global.help_box=false
		if frame==8:
			ap.pause()

		else:
			ap.play()
	else :
		if frame !=0:
			ap.play_backwards("open_door")
			global.help_box=false
		else:
			ap.play("default")

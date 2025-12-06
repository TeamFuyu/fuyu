extends AnimatedSprite2D
@onready var player = get_node("../global_node/Fuyu")
@onready var PORTEE = 300
@onready var DECALAGE_X = 0
@onready var DECALAGE_Y = 0
@onready var ap = $"."
@onready var dialogue_en_cours = false

func _process(_delta):
	if portée(ap):
		if Input.is_action_pressed("interact"):# à remplacer par la touche choise pour le dialogue
			dialogue_en_cours = true
	else :
		dialogue_en_cours = false
		
	if dialogue_en_cours:
		if animation!="idle bras fermés":
			if ap.frame!=6 :
				ap.play("ferme les bras")
			else :
				ap.play("idle bras fermés")	
	if !portée(ap) :
		if animation!="default":
			if ap.frame!=0 :
				ap.play_backwards("ferme les bras")
			else :
				ap.play("default")
		#dialogue : ça sera fait :)
		
		
func portée(personnage)->bool:
	return int(player.position.x) > personnage.position.x-PORTEE+DECALAGE_X and int(player.position.x) < personnage.position.x+PORTEE+DECALAGE_X and int(player.position.y) > personnage.position.y-PORTEE+DECALAGE_Y and int(player.position.y) < personnage.position.y+PORTEE+DECALAGE_Y 

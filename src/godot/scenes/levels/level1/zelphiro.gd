extends AnimatedSprite2D
@onready var player = get_node("../global_node/Fuyu")
@onready var PORTEE = 300
@onready var DECALAGE_X = -200
@onready var DECALAGE_Y = -10


func _process(_delta):
	if portée($"."):
		dial.p(0, "Salut, toi !")
		dial.p(1, "Test de dialogue !")
		dial.show_dialogue()

func portée(personnage)->bool:
	return int(player.position.x) > personnage.position.x-PORTEE+DECALAGE_X and int(player.position.x) < personnage.position.x+PORTEE+DECALAGE_X and int(player.position.y) > personnage.position.y-PORTEE+DECALAGE_Y and int(player.position.y) < personnage.position.y+PORTEE+DECALAGE_Y 

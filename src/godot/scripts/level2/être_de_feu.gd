extends AnimatedSprite2D
@onready var player = get_node("../global_node/Fuyu")
@onready var PORTEE = 300
@onready var DECALAGE_X = 0
@onready var DECALAGE_Y = 0

func _process(_delta):
	if global.portée(player,$".",PORTEE, DECALAGE_X, DECALAGE_Y):
		if Input.is_action_pressed("interact"):
			global.dialog={"Bienvenue dans le Temple de Soleira. Que viens-tu faire ici ?":0,
			"Je suis tombé de la montagne, là-haut. Je veux y retourner !":1,
			"Pour cela, tu devras accomplir une longue quête parsemée d'embûches !":0}
			$".".play("arms")
			global.dial_running=true
	else:
		#global.dial_running = false
		#$".".play("idle")
		pass

extends Node
@export var stuff_content=["pomme","pêche","poire","abricot"]
@export var dialog=[]
@onready var mort=false
@export var max_health: int = 5
@export var current_health: int = 5
@export var dial_running=false
@export var help_box=false

#Characters properties : tableau
@export var characters = ["Fuyu", "Vieux"]
@export var characters_textures = ["fuyu_portrait_contour/0.png", "tous sprites de vieux/0.png"]
@export var characters_colors = ["purple", "white"]

func portée(player,personnage,portee, DECALAGE_X, DECALAGE_Y)->bool:
	return int(player.position.x) > personnage.position.x-portee+DECALAGE_X and int(player.position.x) < personnage.position.x+portee+DECALAGE_X and int(player.position.y) > personnage.position.y-portee+DECALAGE_Y and int(player.position.y) < personnage.position.y+portee+DECALAGE_Y 

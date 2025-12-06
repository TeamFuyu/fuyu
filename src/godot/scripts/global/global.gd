extends Node
@export var stuff_content=["pomme","pêche","poire","abricot"]
@export var dialog=[]
@onready var mort=false
@export var max_health: int = 5
@export var current_health: int = 5

#Characters properties
@export var characters = ["Fuyu", "Vieux"]
@export var characters_textures = ["fuyu_portrait_contour/0.png", "tous sprites de vieux/0.png"]
@export var characters_colors = ["purple", "white"]

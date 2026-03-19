extends Panel
var current_line: int = 0
@onready var dbox=$DialLabel
@onready var chbox=$ChLabel
@onready var dtexture=$ChTexture

func _process(_delta):
	if global.dial_running:
		show_dialogue()
		global.dial_running=false
	if Input.is_action_just_pressed("confirm") and current_line>=1:
		show_next_dialogue_line()
 
func show_next_dialogue_line():
	if current_line>=len(global.dialog):
		close()
	else:
		var carac_number = global.dialog.values()[current_line]
		chbox.text = global.characters[carac_number]
		dbox.text = global.dialog.keys()[current_line]
		dtexture.texture = load("res://assets/portraits/"+global.characters_textures[carac_number])
		chbox.add_theme_color_override("font_color", Color(global.characters_colors[carac_number]))
		current_line += 1
 
func close():
	$".".visible = false
	current_line = 0
	

func show_dialogue():
	"""
	var cur_character = global.characters[0]
	print(cur_character)
	dbox.text = global.dialog.keys()[0]
	chbox.text = cur_character
	dtexture.texture = load("res://assets/portraits/"+global.characters_textures[0])
	chbox.add_theme_color_override("font_color", Color(global.characters_colors[0]))
	"""
	$".".visible = true
	show_next_dialogue_line()

func _ready():
	$".".visible = false

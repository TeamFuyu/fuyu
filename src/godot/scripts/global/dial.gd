extends Panel
var current_line: int = 0
@onready var dbox=$DialLabel
@onready var chbox=$ChLabel
@onready var dtexture=$ChTexture

func _process(_delta):
	if global.dial_running and not global.dnd:
		show_dialogue()
		global.dnd=true
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
	global.dnd=false
	

func show_dialogue():
	$".".visible = true
	show_next_dialogue_line()

func _ready():
	$".".visible = false

extends Panel

var dbox_text: Array
var dbox_characters: Array
var current_line: int = 0
var character: int

func _process(_delta):
	if Input.is_action_just_pressed("confirm"):
		show_next_dialogue_line()
	if global.dial_running:
		show_dialogue()
		global.dial_running=false
 
func show_next_dialogue_line():
	if current_line>=len(dbox_text)-1:
		close()
	else:
		current_line += 1
		print(dbox_characters)
		print(dbox_characters[current_line])
		print(global.characters[dbox_characters[current_line]])
		$ChLabel.text = global.characters[dbox_characters[current_line]]
		$DialLabel.text = dbox_text[current_line]
		$ChTexture.texture = load("res://assets/portraits/"+global.characters_textures[dbox_characters[current_line]])
		$ChLabel.add_theme_color_override("font_color", Color(global.characters_colors[dbox_characters[current_line]]))
 
func close():
	$".".visible = false
	current_line = 0
	dbox_text = []
	dbox_characters = []

func dialog_visible():
	$".".visible = true

func p(c, text):
	dbox_text.append(text)
	dbox_characters.append(c)

func show_dialogue():
	$DialLabel.text = dbox_text[0]
	$ChLabel.text = global.characters[dbox_characters[0]]
	$ChTexture.texture = load("res://assets/portraits/"+global.characters_textures[dbox_characters[0]])
	$ChLabel.add_theme_color_override("font_color", Color(global.characters_colors[dbox_characters[0]]))
	dialog_visible()

func _ready():
	$".".visible = false

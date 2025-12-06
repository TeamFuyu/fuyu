extends Panel

var dbox_text: Array
var dbox_characters: Array
var current_line: int = 1
var character: int
var ls = LabelSettings.new()

func _ready():
	$".".visible = false

func _process(_delta):
	if Input.is_action_just_pressed("confirm"):
		show_next_dialogue_line()
 
func show_next_dialogue_line():
	if current_line>=len(dbox_text):
		close()
	else:
		print(dbox_characters)
		print(dbox_characters[current_line])
		print(global.characters[dbox_characters[current_line]])
		$Label.text = global.characters[dbox_characters[current_line]]
		$RichTextLabel.text = dbox_text[current_line]
		$TextureRect.texture = load("res://assets/portraits/"+global.characters_textures[dbox_characters[current_line]])
		$Label.add_theme_color_override("font_color", Color(global.characters_colors[dbox_characters[current_line]]))
		current_line += 1
 
func close():
	$".".visible = false
	current_line = 1
	dbox_text = []
	dbox_characters = []

func dialog_visible():
	$".".visible = true

func p(c, text):
	dbox_text.append(text)
	dbox_characters.append(c)

func show_dialogue():
	$RichTextLabel.text = dbox_text[0]
	$Label.text = global.characters[dbox_characters[0]]
	$TextureRect.texture = load("res://assets/portraits/"+global.characters_textures[dbox_characters[0]])
	$Label.add_theme_color_override("font_color", Color(global.characters_colors[dbox_characters[0]]))
	dialog_visible()

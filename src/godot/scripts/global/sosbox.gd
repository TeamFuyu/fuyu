extends PopupPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global.help_box:
		$".".visible=true
		show_msg("Astuce !",global.help_box)
	else:
		$".".visible=false
func show_msg(title,content):
	$Corps.text=title+"\n"+content

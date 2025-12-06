extends Control

@export var full_heart_texture: Texture2D
@export var empty_heart_texture: Texture2D

@onready var health_container: HBoxContainer = $edelweiss/CanvasLayer/edelweiss_container

var invincibility = false

func _ready():
	if health_container == null:
		print("Error: edelweiss_container node not found! Please create an HBoxContainer named 'edelweiss_container' as a child.")
		return
	_update_hearts_display()

func _process(_delta):
	if $"mort".is_colliding():
		global.mort = true
	if global.mort and invincibility==false:
		invincibility = true
		take_damage()
		teleport_to_last_checkpoint()
		global.mort = false
		$MagicPotionTimer.start()
	if global.current_health==0:
		get_tree().change_scene_to_file("res://scenes/ui/gameover.tscn")

func _update_hearts_display():
	for child in health_container.get_children():
		child.queue_free()

	for i in range(global.max_health):
		var heart_node = TextureRect.new()
		heart_node.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		heart_node.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		heart_node.custom_minimum_size = Vector2(75, 75)

		if i < global.current_health:
			heart_node.texture = full_heart_texture
		else:
			heart_node.texture = empty_heart_texture

		health_container.add_child(heart_node)

func take_damage(amount: int = 1):
	global.current_health -= amount
	if global.current_health < 0:
		global.current_health = 0
	print("Health decreased to: ", global.current_health)
	_update_hearts_display()

func heal(amount: int = 1):
	global.current_health += amount
	if global.current_health > global.max_health:
		global.current_health = global.max_health
	print("Health increased to: ", global.current_health)
	_update_hearts_display()

func set_health(value: int):
	global.current_health = clampi(value, 0, global.max_health)
	print("Health set to: ", global.current_health)
	_update_hearts_display()

func last_floor_touched():
	if get_node("../Fuyu").is_on_floor():
		get_node("../Fuyu").last_floor_poz_y = get_node("../Fuyu").position.y
		get_node("../Fuyu").last_floor_poz_x = get_node("../Fuyu").position.x

func teleport_to_last_checkpoint():
	var fuyu_node = get_node("../Fuyu")
	fuyu_node.position.x = fuyu_node.last_floor_poz_x
	fuyu_node.position.y = fuyu_node.last_floor_poz_y


func _on_magic_potion_timer_timeout():
	global.mort = false
	invincibility = false
	$MagicPotionTimer.stop()

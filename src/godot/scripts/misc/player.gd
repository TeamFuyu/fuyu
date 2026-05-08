extends CharacterBody2D

@export var gravity = 1500
@export var jump_force = -800.0
@export var orientation = 0
var is_crouching = false
var standing_cshape = preload("res://resources/cshape/fuyu_idle_cshape.tres")
var crouching_cshape = preload("res://resources/cshape/fuyu_crouch_cshape.tres")
var stuck_under_object = false
var jump = 0
var tween: Tween
var dash_velocity := 0
var can_dash = true
var in_dash = false
var is_attacking = false
const SPEED := 600.0
const DASH := 2000

@onready var ap = $AnimatedSprite2D
@onready var sprite = $AnimatedSprite2D
@onready var cshape = $CollisionShape2D
@onready var crouchraycast_1 = $CrouchRaycast_1
@onready var crouchraycast_2 = $CrouchRaycast_2

@onready var last_floor_poz_y = -116.0
@onready var last_floor_poz_x = -584.04

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 1000:
			velocity.y = 1000

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump = 0
			velocity.y = jump_force
			jump = 1
		elif jump == 1:
			await get_tree().create_timer(0.15).timeout
			velocity.y = jump_force / 1.5
			jump = 2

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * (SPEED + dash_velocity)
		if dash_velocity > 0:
			dash_velocity -= 100
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0:
		sprite.flip_h = (direction == 1)

	if Input.is_action_just_pressed("crouch"):
		is_crouching = true
		cshape.shape = crouching_cshape
		cshape.position.y = -36
	elif Input.is_action_just_released("crouch"):
		if above_head_is_empty():
			stand()
		else:
			if stuck_under_object != true:
				stuck_under_object = true

	if stuck_under_object && above_head_is_empty():
		if !Input.is_action_just_pressed("crouch"):
			stand()
			stuck_under_object = false

	if Input.is_action_just_pressed("dash"):
		if can_dash:
			can_dash = false
			in_dash = true
		if direction != 0:
			dash_velocity = DASH
		else:
			if sprite.flip_h:
				velocity.x = DASH * 3
			else:
				velocity.x = -DASH * 3
	if Input.is_action_just_released("dash"):
		in_dash = false
	
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
	elif Input.is_action_just_released("attack"):
		is_attacking = false

		if tween:
			tween.stop()
			tween = create_tween()
			tween.tween_property(self, "dash_velocity", 0, 0.3).set_ease(Tween.EASE_OUT)

		var _timer = $DashTimer
		$DashTimer.start()
	if Input.is_action_just_pressed("interact"):
		global.help_box=false

	move_and_slide()
	update_animations("attack",direction)

func above_head_is_empty() -> bool:
	var result = !crouchraycast_1.is_colliding() && !crouchraycast_2.is_colliding()
	return result

func update_animations(anim_name:String,direction):
	if is_crouching:
		if direction == 0:
			ap.play("crouch")
		else:
			ap.play("crouch_walk")
	elif in_dash:
		ap.play("dash")
	elif is_attacking:
		ap.play_backwards("attack")
	elif is_on_floor():
		if direction == 0:
			ap.play("idle")
		else:
			ap.play("walk")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")

func stand():
	if is_crouching == false:
		return
	is_crouching = false
	cshape.shape = standing_cshape
	cshape.position.y = -51

func _ready():
	var _timer = $DashTimer
	get_node("DashTimer").timeout.connect(_on_DashTimer_timeout)

func _on_DashTimer_timeout():
	#in_dash = false
	can_dash = true
	$DashTimer.stop()
	

#func save():
	#var save_dict = {
		#"filename": get_scene_file_path(),
		#"parent": get_parent().get_path(),
		#"pos_x": position.x,
		#"pos_y": position.y,
	#}
	#return save_dict

#func save_game():
	#var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	#var save_nodes = get_tree().get_nodes_in_group("Persist")
	#for node in save_nodes:
		#if node.scene_file_path.is_empty():
			#print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			#continue
		#if !node.has_method("save"):
			#print("persistent node '%s' is missing a save() function, skipped" % node.name)
			#continue
		#var node_data = node.call("save")
		#var json_string = JSON.stringify(node_data)
		#save_file.store_line(json_string)

#func load_game():
	#if not FileAccess.file_exists("user://savegame.save"):
		#return
	#var save_nodes = get_tree().get_nodes_in_group("Persist")
	#for i in save_nodes:
		#i.queue_free()
	#var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	#while save_file.get_position() < save_file.get_length():
		#var json_string = save_file.get_line()
		#var json = JSON.new()
		#var parse_result = json.parse(json_string)
		#if not parse_result == OK:
			#print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			#continue
		#var node_data = json.data
		#var new_object = load(node_data["filename"]).instantiate()
		#get_node(node_data["parent"]).add_child(new_object)
		#new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		#for i in node_data.keys():
			#if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				#continue
			#new_object.set(i, node_data[i])

 # Replace with function body.

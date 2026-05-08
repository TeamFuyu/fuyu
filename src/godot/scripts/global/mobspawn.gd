extends Node2D

@export var mob_scene = preload("res://scenes/mob.tscn")
var spawn_interval: float = 0.0 # Seconds between each mob spaw. 0 -> Only one mob
var spawning = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawning:
		spawn()
		spawning = false

func spawn() -> void:
	var mob = mob_scene.instantiate() as RigidBody2D
	mob.position=Vector2(randi_range(50, get_viewport_rect().size.x - 50),-50)
	add_child(mob)

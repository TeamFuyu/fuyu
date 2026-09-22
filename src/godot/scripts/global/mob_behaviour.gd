extends RigidBody2D


func _ready() -> void:
	play_animation()


func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func play_animation():
	var mob_anims = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation=mob_anims.pick_random() # to be changed later
	$AnimatedSprite2D.play()

func start(behaviour_creator: Callable):
	behaviour_creator.call()

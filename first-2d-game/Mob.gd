extends RigidBody2D

var mob_size = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$AnimatedSprite.playing = true
	
	#var mob_types = $AnimatedSprite.frames.get_animation_names()
	#$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _integrate_forces(state):
	set_scale(Vector2(mob_size, mob_size))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

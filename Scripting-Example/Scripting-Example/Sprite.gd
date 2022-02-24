extends Node2D

var speed = 100
var angular_speed = PI

func _process(delta):
	# Set rotation
	var rot_dir = 0
	if Input.is_action_pressed("ui_left"):
		rot_dir = -1
	if Input.is_action_pressed("ui_right"):
		rot_dir = 1
		
	rotation += angular_speed * delta * rot_dir
	
	# Set velocity
	var vel_dir = 0
	if Input.is_action_pressed("ui_up"):
		vel_dir = 1
	
	var velocity = Vector2.UP.rotated(rotation) * speed * vel_dir
	position += velocity * delta

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = get_node("Sprite/Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")
	
# When the timer times out
func _on_Timer_timeout():
	visible = not visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# 
func _on_Toggle_Motion_Button_pressed():
	set_process(not is_processing())

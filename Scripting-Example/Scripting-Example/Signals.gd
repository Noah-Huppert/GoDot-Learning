extends Node2D

var health_value_label = null
var health_value = 3

signal health_down(health_value)

# Called when the node enters the scene tree for the first time.
func _ready():
	health_value_label = get_node("Health Value Label")
	health_value_label.text = str(health_value)
	
func _on_Down_Health_Button_pressed():
	if health_value > 0:
		health_value -= 1
		emit_signal("health_down", health_value)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

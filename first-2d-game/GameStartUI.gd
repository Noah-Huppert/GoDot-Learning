extends Node2D

# When the game logic should start running
signal game_start

export var countdown_length = 3
var countdown_total = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func set_countdown(countdown):
	$Countdown.text = "%d!" % countdown
	
func start():
	show()
	countdown_total = 0
	set_countdown(countdown_length)
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	countdown_total += 1
	set_countdown(countdown_length - countdown_total)
	
	# If done
	if countdown_total == countdown_length:
		$Timer.stop()
		hide()
		emit_signal("game_start")

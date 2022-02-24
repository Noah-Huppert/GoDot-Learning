extends Node2D

# When the user whishes to try again
signal try_again

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func set_game_over(score, difficulty):
	$ScoreLabel.text = "Score %d (x%d)" % [score, difficulty]
	show()


func _on_TryAgainButton_pressed():
	emit_signal("try_again")

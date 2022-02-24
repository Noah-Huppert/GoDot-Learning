extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameMultiplier.text = ""
	$GamePhaseLabel.text = ""
	
func display_score(score, difficulty):
	$GamePhaseLabel.text = "Score %d" % score
	$GameMultiplier.text = "x%d" % difficulty

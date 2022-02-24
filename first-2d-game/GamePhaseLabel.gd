extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameMultiplier.text = ""
	$GamePhaseLabel.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func display_new_game():
	$GamePhaseLabel.text = "New Game!"
	$GameMultiplier.text = ""
	
func display_score(score, difficulty):
	$GamePhaseLabel.text = "Score %d" % score
	$GameMultiplier.text = "x%d" % difficulty

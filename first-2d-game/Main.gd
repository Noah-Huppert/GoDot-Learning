extends Node

# The mob to spawn
export(PackedScene) var mob_scene

# The game score
var score

# Difficulty, high is harder, cannot be 0
var difficulty = 1
var UPDATE_DIFFICULTY_EVERY_SCORE = 10
var MAX_DIFFICULTY = 5

var game_score_label

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize randomizer
	randomize()
	
	game_score_label = $GameScoreLabel
	
	# Setup game state
	new_game()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Initialize game
func new_game():
	$GameOverUI.hide()
	$GameStartUI.start()
	
	score = 0
	difficulty = 1
	$Player.start($StartPosition.position)
	$Player.hide()
	
	update_mob_spawn_timer()
	
# When the player is hit
func game_over():
	# Stop timers
	$ScoreTimer.stop()
	$MobSpawnTimer.stop()
	
	# Hide player
	$Player.hide()
	
	# Remove enemies
	for mob in $Mobs.get_children():
		mob.queue_free()
	
	# Setup UI
	game_score_label.hide()
	$GameOverUI.set_game_over(score, difficulty)

# Begin the game after a delay
func begin_game():
	game_score_label.show()
	game_score_label.display_score(score, difficulty)
	
	$MobSpawnTimer.start()
	$ScoreTimer.start()
	$Player.start($StartPosition.position)

# Spawn mobs regularly
func _on_MobSpawnTimer_timeout():
	# Setup mob to spawn
	var mob = mob_scene.instance()
	$Mobs.add_child(mob)
	
	var mob_spawn_pos = get_node("MobPath/MobSpawnPosition")
	
	# Random position along the MobPath
	mob_spawn_pos.offset = randi()
	mob.position = mob_spawn_pos.position
	
	# Make it rotate to face inward
	mob.rotation = mob_spawn_pos.rotation + rand_range(PI / 4, (3* PI) / 4)
	
	# Set a velocity rotated in the direction its facing
	mob.linear_velocity = Vector2(150.0, 0.0).rotated(mob.rotation)
	
	# Make it smaller the harder difficulty it is
	mob.mob_size = 1 / difficulty
	
	mob.show()

func _on_ScoreTimer_timeout():
	# Increase score
	score += 1
	
	# Increase difficulty
	var new_diff = floor(score / UPDATE_DIFFICULTY_EVERY_SCORE) + 1
	if new_diff > difficulty and new_diff <= MAX_DIFFICULTY:
		difficulty = new_diff
		update_mob_spawn_timer()
		
	game_score_label.display_score(score, difficulty)
	
# Based on the current difficulty	
func update_mob_spawn_timer():
	$MobSpawnTimer.wait_time = 1 / difficulty

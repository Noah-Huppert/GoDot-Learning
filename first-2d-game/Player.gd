extends Area2D

# When player is collided
signal hit

# Pixels / second speed of player
export var speed = 400

# Size of screen vector2
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

	hide()
	
	print("Player ready")

func _process(delta):
	# Player velocity
	var velocity = Vector2.ZERO
	
	# Handle input
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	# Normalize, if player is inputing two actions on the same axis
	velocity = velocity.normalized()
		
	# Apply speed factor and play animation
	if velocity.length() > 0:
		velocity = velocity * speed
		
		# Show correct animation for action
		$AnimatedSprite.flip_v = velocity.y > 0
		
		if velocity.x > 0:
			rotation = PI / 2
		elif velocity.x < 0:
			rotation = -1 * PI / 2
		else:
			rotation = 0
		
	# Apply velocity to position
	position += velocity * delta
	
	# Keep on screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

# When a body collides with the player
func _on_Player_body_entered(body):
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
	print("Player body entered")

func start(pos):
	position = position
	show()
	$CollisionShape2D.disabled = false
	
	print("Player start")

extends Node2D

export(PackedScene) var witch_scene
onready var score = 0
onready var time = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()
	
func _process(delta):
	$HUD.update_score(score)
	$HUD.update_time(time)
	
	if time == 0:
		game_over()
		var final_score = score
		$HUD.update_final_score(final_score)
		$HUD/GameOverScreen.show()

func game_over():
	$WitchTimer.stop()
	$CatSpawnTimer.stop()
#	$LevelTimer.stop()

func new_game():
	$HUD/GameOverScreen.hide()
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.update_time(time)

func _on_StartTimer_timeout():
	$WitchTimer.start()
	$CatSpawnTimer.start()
	$LevelTimer.start()

func _on_WitchTimer_timeout():
	 # Create a new instance of the Mob scene.
	var witch = witch_scene.instance()
	
	# Choose a random location on Path2D.
	var witch_spawn_location = get_node("WitchPath/WitchSpawnLocation")
	witch_spawn_location.offset = randi()
	
	# Set the mob's direction perpendicular to the path direction.
	#var direction = witch_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location.
	witch.position = witch_spawn_location.position
	
	# Add some randomness to the direction.
	#direction += rand_range(-PI / 4, PI / 4)
	#witch.rotation = direction
	
	# Choose the velocity for the mob.
	#var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	#witch.linear_velocity = velocity.rotated(direction)
	
	add_child(witch)

func _on_SafeZone_body_entered(body):
	if body.is_in_group("cat"):
		score += 1

func _on_SafeZone_body_exited(body):
	if body.is_in_group("cat"):
		score -= 1

func _on_LevelTimer_timeout():
	time -= 1

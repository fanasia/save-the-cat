extends Node2D

export(PackedScene) var witch_scene

const GameOverScreen = preload("res://scenes/GameOverScreen.tscn")
const PauseScene = preload("res://scenes/PauseScene2.tscn")

onready var score = 0
onready var time = 45

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		var pause = PauseScene.instance()
		add_child(pause)
		get_tree().paused = true
#		$PauseScene.visible = true
#		get_tree().paused = true
	
func _process(delta):
	if $BackgroundMusic.playing == false:
		$BackgroundMusic.play()
	
	$HUD.update_score(score)
	$HUD.update_time(time)
	
	if time == 0:
		var final_score = score
		game_over(final_score)

func game_over(final_score):
	$WitchTimer.stop()
	$CatSpawnTimer.stop()
	$LevelTimer.stop()

	var game_over = GameOverScreen.instance()
	add_child(game_over)
	game_over.update_final_score(final_score)
	get_tree().paused = true

func new_game():
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

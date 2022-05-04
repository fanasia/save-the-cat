extends CanvasLayer

signal start_game

# func show_message(text):
#    $Message.text = text
#    $Message.show()
#    $MessageTimer.start()

#func show_game_over():
#	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
#	yield($MessageTimer, "timeout")

#	$Message.text = "Dodge the\nCreeps!"
#	$Message.show()
	# Make a one-shot timer and wait for it to finish.
#	yield(get_tree().create_timer(1), "timeout")
#	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_time(time):
	$TimerLabel.text = str(time)

func update_final_score(score):
	$GameOverScreen/CenterContainer/VBoxContainer/HBoxContainer/FinalScoreValue.text = str(score)

func _on_RestartButton_pressed():
	get_tree().change_scene("res://scenes/Level_0.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/Landing.tscn")

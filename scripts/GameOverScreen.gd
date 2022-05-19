extends CanvasLayer

func update_final_score(score):
	$GameOverScreen/CenterContainer/VBoxContainer/HBoxContainer/FinalScoreValue.text = str(score)

func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Level_0.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Landing.tscn")

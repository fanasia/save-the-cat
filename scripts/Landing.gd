extends Control

const HelpScene = preload("res://scenes/HowToPlayScreen.tscn")

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/Level_0.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_HowToPlayButton_pressed():
	var help = HelpScene.instance()
	add_child(help)

extends Control

const HelpScene = preload("res://scenes/HowToPlayScreen.tscn")

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = false
	get_tree().paused = is_paused
	visible = is_paused

func _on_UnpauseButton_pressed():
	self.is_paused = false

func _on_HelpButton_pressed():
	var help = HelpScene.instance()
	add_child(help)


func _on_QuitButton_pressed():
	get_tree().quit()

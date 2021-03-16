extends Control

func _on_ExitButton_pressed():
	get_tree().quit()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_AboutButton_pressed():
	get_tree().change_scene("res://scenes/About.tscn")

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_DifficultyButton_pressed():
	get_tree().change_scene("res://scenes/DifficultyMenu.tscn")

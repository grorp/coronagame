extends Control

func _on_ExitButton_pressed():
	Global.click_sound.play()
	get_tree().change_scene("res://scenes/ConfirmExitMenu.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.click_sound.play()
		get_tree().change_scene("res://scenes/ConfirmExitMenu.tscn")

func _on_AboutButton_pressed():
	Global.click_sound.play()
	get_tree().change_scene("res://scenes/About.tscn")

func _on_PlayButton_pressed():
	Global.click_sound.play()
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_DifficultyButton_pressed():
	Global.click_sound.play()
	get_tree().change_scene("res://scenes/DifficultyMenu.tscn")

func _on_SkinsButton_pressed():
	Global.click_sound.play()
	get_tree().change_scene("res://scenes/SkinMenu.tscn")

extends Control

func _on_BackButton_pressed():
	Global.click_sound.play()
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.click_sound.play()
		get_tree().change_scene("res://scenes/MainMenu.tscn")

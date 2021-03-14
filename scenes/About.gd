extends Control

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

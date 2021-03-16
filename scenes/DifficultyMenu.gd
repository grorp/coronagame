extends Control

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_EasyButton_pressed():
	Global.difficulty = Global.Difficulty.EASY
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_NormalButton_pressed():
	Global.difficulty = Global.Difficulty.NORMAL
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_HardButton_pressed():
	Global.difficulty = Global.Difficulty.HARD
	get_tree().change_scene("res://scenes/MainMenu.tscn")

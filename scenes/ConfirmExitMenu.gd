extends Control

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_CancelButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

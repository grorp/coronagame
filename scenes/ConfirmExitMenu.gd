extends Control

func _on_ExitButton_pressed():
	Global.click_sound.play()
	yield(get_tree().create_timer(0.15), "timeout")
	get_tree().quit()

func _on_CancelButton_pressed():
	Global.click_sound.play()
	get_tree().change_scene("res://scenes/MainMenu.tscn")

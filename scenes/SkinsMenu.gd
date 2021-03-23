extends Control

func _ready():
	if Global.player_skin == Global.PlayerSkins.EYE:
		$HBoxContainer/VBoxContainer2/GlassesButton.hide()

func _on_CoronaButton_pressed():
	Global.player_skin = Global.PlayerSkins.CORONA
	$HBoxContainer/VirusPreview.set_textures()
	$HBoxContainer/VBoxContainer2/GlassesButton.show()
	Global.save_settings()

func _on_RobotButton_pressed():
	Global.player_skin = Global.PlayerSkins.ROBOT
	$HBoxContainer/VirusPreview.set_textures()
	$HBoxContainer/VBoxContainer2/GlassesButton.show()
	Global.save_settings()

func _on_RainbowButton_pressed():
	Global.player_skin = Global.PlayerSkins.RAINBOW
	$HBoxContainer/VirusPreview.set_textures()
	$HBoxContainer/VBoxContainer2/GlassesButton.show()
	Global.save_settings()

func _on_EyeButton_pressed():
	Global.player_skin = Global.PlayerSkins.EYE
	if Global.player_accessoire == Global.PlayerAccessoires.GLASSES:
		Global.player_accessoire = Global.PlayerAccessoires.NOTHING
	$HBoxContainer/VirusPreview.set_textures()
	$HBoxContainer/VBoxContainer2/GlassesButton.hide()
	Global.save_settings()

func _on_GlassesButton_pressed():
	if Global.player_accessoire != Global.PlayerAccessoires.GLASSES:
		Global.player_accessoire = Global.PlayerAccessoires.GLASSES
	else:
		Global.player_accessoire = Global.PlayerAccessoires.NOTHING
	$HBoxContainer/VirusPreview.set_textures()
	Global.save_settings()

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

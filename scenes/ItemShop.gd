extends Control

func _ready():
	if Global.player_skin == Global.PlayerSkins.ROBOT:
		$HBoxContainer/PreviewContainer/Preview.texture = load("res://assets/textures/virus/virus_robot.png")
	elif Global.player_skin == Global.PlayerSkins.RAINBOW:
		$HBoxContainer/PreviewContainer/Preview.texture = load("res://assets/textures/virus/virus_rainbow.png")
	
	if Global.player_accessoire == Global.PlayerAccessoires.GLASSES:
		$HBoxContainer/PreviewContainer/AccessoirePreview.texture = load("res://assets/textures/virus/virus_glasses.png")

func _on_CoronaButton_pressed():
	Global.player_skin = Global.PlayerSkins.CORONA
	$HBoxContainer/PreviewContainer/Preview.texture = load("res://assets/textures/virus/virus.png")
	Global.save_settings()

func _on_RobotButton_pressed():
	Global.player_skin = Global.PlayerSkins.ROBOT
	$HBoxContainer/PreviewContainer/Preview.texture = load("res://assets/textures/virus/virus_robot.png")
	Global.save_settings()

func _on_RainbowButton_pressed():
	Global.player_skin = Global.PlayerSkins.RAINBOW
	$HBoxContainer/PreviewContainer/Preview.texture = load("res://assets/textures/virus/virus_rainbow.png")
	Global.save_settings()

func _on_GlassesButton_pressed():
	if Global.player_accessoire != Global.PlayerAccessoires.GLASSES:
		Global.player_accessoire = Global.PlayerAccessoires.GLASSES
		$HBoxContainer/PreviewContainer/AccessoirePreview.texture = load("res://assets/textures/virus/virus_glasses.png")
	else:
		Global.player_accessoire = Global.PlayerAccessoires.NOTHING
		$HBoxContainer/PreviewContainer/AccessoirePreview.texture = null
	Global.save_settings()

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

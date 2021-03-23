extends Control

func _ready():
	set_textures()

func set_textures():
	if Global.player_skin == Global.PlayerSkins.CORONA:
		$TextureRect.texture = load("res://assets/textures/virus/virus.png")
	elif Global.player_skin == Global.PlayerSkins.ROBOT:
		$TextureRect.texture = load("res://assets/textures/virus/virus_robot.png")
	elif Global.player_skin == Global.PlayerSkins.RAINBOW:
		$TextureRect.texture = load("res://assets/textures/virus/virus_rainbow.png")
	
	if Global.player_accessoire == Global.PlayerAccessoires.GLASSES:
		$AccessoireTextureRect.texture = load("res://assets/textures/virus/virus_glasses.png")
	else:
		$AccessoireTextureRect.texture = null

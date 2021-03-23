extends Control

func _ready():
	set_textures()

func set_textures():
	$TextureRect.texture = Global.PLAYER_SKIN_TEXTURES[Global.player_skin]
	$AccessoireTextureRect.texture = Global.PLAYER_ACCESSOIRE_TEXTURES[Global.player_accessoire]

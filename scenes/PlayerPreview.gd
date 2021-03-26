extends Control

func _ready():
	set_textures()

func set_textures():
	$TextureRect.texture = Global.PLAYER_SKINS[Global.player_skin]
	for node in $Accessoires.get_children():
		node.queue_free()
	for accessoire in Global.player_accessoires:
		var texture_rect = TextureRect.new()
		if Global.PLAYER_ACCESSOIRES[accessoire][1].has(Global.player_skin):
			texture_rect.texture = Global.PLAYER_ACCESSOIRES[accessoire][1][Global.player_skin]
		else:
			texture_rect.texture = Global.PLAYER_ACCESSOIRES[accessoire][0]
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.anchor_right = 1
		texture_rect.anchor_bottom = 1
		$Accessoires.add_child(texture_rect)

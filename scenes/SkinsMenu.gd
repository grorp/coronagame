extends Control

func _ready():
	for skin in Global.PlayerSkins:
		var btn = TextureButton.new()
		btn.texture_normal = Global.PLAYER_SKIN_TEXTURES[Global.PlayerSkins[skin]]
		btn.rect_min_size = Vector2(200, 200)
		btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btn.expand = true
		btn.connect("pressed", self, "_on_SkinButton_pressed", [skin])
		$HBoxContainer/VBoxContainer/SkinList.add_child(btn)
	
	for accessoire in Global.PlayerAccessoires:
		if accessoire == "NOTHING":
			continue
		var btn = TextureButton.new()
		btn.texture_normal = Global.PLAYER_ACCESSOIRE_TEXTURES[Global.PlayerAccessoires[accessoire]]
		btn.rect_min_size = Vector2(200, 200)
		btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btn.expand = true
		btn.connect("pressed", self, "_on_AccessoireButton_pressed", [accessoire])
		$HBoxContainer/AccessoiresList.add_child(btn)

func _on_SkinButton_pressed(skin):
	Global.player_skin = Global.PlayerSkins[skin]
	Global.save_settings()
	$HBoxContainer/VirusPreview.set_textures()

func _on_AccessoireButton_pressed(accessoire):
	if Global.player_accessoire != Global.PlayerAccessoires[accessoire]:
		Global.player_accessoire = Global.PlayerAccessoires[accessoire]
	else:
		Global.player_accessoire = Global.PlayerAccessoires.NOTHING
	Global.save_settings()
	$HBoxContainer/VirusPreview.set_textures()

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

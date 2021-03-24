extends Control

func _ready():
	for skin in Global.PLAYER_SKINS:
		var btn = TextureButton.new()
		btn.texture_normal = Global.PLAYER_SKINS[skin]
		btn.rect_min_size = Vector2(150, 150)
		btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btn.expand = true
		btn.connect("pressed", self, "_on_SkinButton_pressed", [skin])
		$HBoxContainer/VBoxContainer/ScrollContainer/SkinList.add_child(btn)
	
	for accessoire in Global.PLAYER_ACCESSOIRES:
		var btn = TextureButton.new()
		btn.texture_normal = Global.PLAYER_ACCESSOIRES[accessoire][0]
		btn.rect_min_size = Vector2(150, 150)
		btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btn.expand = true
		btn.connect("pressed", self, "_on_AccessoireButton_pressed", [accessoire])
		$HBoxContainer/ScrollContainer/AccessoireList.add_child(btn)
	
	$HBoxContainer/VBoxContainer/ScrollContainer.get_v_scrollbar().connect("visibility_changed", self, "on_ListScrollbar_visibility_changed", [$HBoxContainer/VBoxContainer/ScrollContainer])
	$HBoxContainer/ScrollContainer.get_v_scrollbar().connect("visibility_changed", self, "on_ListScrollbar_visibility_changed", [$HBoxContainer/ScrollContainer])

func _on_SkinButton_pressed(skin):
	Global.player_skin = skin
	Global.save_settings()
	$HBoxContainer/CenterContainer/VirusPreview.set_textures()

func _on_AccessoireButton_pressed(accessoire):
	if !Global.player_accessoires.has(accessoire):
		Global.player_accessoires.push_back(accessoire)
	else:
		Global.player_accessoires.erase(accessoire)
	Global.save_settings()
	$HBoxContainer/CenterContainer/VirusPreview.set_textures()

func on_ListScrollbar_visibility_changed(node):
	if !node.get_v_scrollbar().visible:
		node.rect_min_size.x = 150
	else:
		node.rect_min_size.x = 172

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

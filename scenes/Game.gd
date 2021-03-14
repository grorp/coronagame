extends Node

export (PackedScene) var Spritze

func _ready():
	randomize()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_SpritzenSpawnTimer_timeout():
	$MobPath/MobSpawnLocation.offset = randi()
	var spritze = Spritze.instance()
	add_child(spritze)
	spritze.position = $MobPath/MobSpawnLocation.position
	var offset =  $Player/Camera2D.get_camera_screen_center()
	offset.x -= get_viewport().size.x / 2
	offset.y -= get_viewport().size.y / 2
	spritze.position = offset + spritze.position
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	spritze.rotation = direction
	spritze.linear_velocity = Vector2(rand_range(400, 600), 0)
	spritze.linear_velocity = spritze.linear_velocity.rotated(direction)

func _on_Player_dead(enemy):
	$SpritzenSpawnTimer.stop()
	enemy.linear_velocity = Vector2(0, 0)
	$HUD/GameOverTxt.show()
	$AfterGameOverTimer.start()

func _on_AfterGameOverTimer_timeout():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

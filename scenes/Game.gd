extends Node

export (PackedScene) var Syringe

var active_syringes = 0

func _ready():
	randomize()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_SyringeSpawnTimer_timeout():
	$MobSpawnPath/MobSpawnLocation.offset = randi()
	var syringe = Syringe.instance()
	add_child(syringe)
	
	syringe.position = $MobSpawnPath/MobSpawnLocation.position
	var offset =  $Player/Camera2D.get_camera_screen_center()
	offset.x -= get_viewport().size.x / 2
	offset.y -= get_viewport().size.y / 2
	syringe.position += offset
	
	var direction = $MobSpawnPath/MobSpawnLocation.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	syringe.rotation = direction
	syringe.linear_velocity = Vector2(rand_range(400, 600), 0)
	syringe.linear_velocity = syringe.linear_velocity.rotated(direction)
	
	active_syringes += 1
	syringe.connect("tree_exited", self, "_on_Syringe_deleted")

func _on_Syringe_deleted():
	active_syringes -= 1
	if $Player.stopped and active_syringes == 0:
		$AfterGameOverTimer.start()

func _on_Player_hit_by_enemy(enemy):
	if not $Player.stopped:
		$Player.stopped = true
		$SyringeSpawnTimer.stop()
		$HUD/GameOverTxt.show()
	enemy.linear_velocity = Vector2(0, 0)
	active_syringes -= 1

func _on_AfterGameOverTimer_timeout():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Player_victim_infected(victim):
	if not victim.infected:
		victim.infect()

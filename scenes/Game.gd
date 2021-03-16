extends Node

export (PackedScene) var Syringe

var active_syringes = 0

func _ready():
	randomize()
	if Global.difficulty == Global.Difficulty.HARD:
		$SyringeSpawnTimer.wait_time = 0.25

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
	
	if Global.difficulty != Global.Difficulty.EASY:
		syringe.look_at($Player.position)
	else:
		syringe.rotation = $MobSpawnPath/MobSpawnLocation.rotation + PI / 2
		syringe.rotation += rand_range(-PI / 4, PI / 4)
	
	if Global.difficulty != Global.Difficulty.HARD:
		syringe.linear_velocity = Vector2(rand_range(400, 600), 0)
	else:
		syringe.linear_velocity = Vector2(rand_range(800, 1000), 0)
	syringe.linear_velocity = syringe.linear_velocity.rotated(syringe.rotation)
	
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

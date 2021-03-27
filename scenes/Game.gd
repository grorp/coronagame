extends Node

export (PackedScene) var Syringe
export (PackedScene) var Human

var generated_chunks = []
const CHUNK_SIZE = Vector2(750, 750)
var chunk_generation_radius = null

var infected_people = 0
var start_time = null
var active_syringes = 0

func _ready():
	_MobSpawnPath_set_points()
	_calculate_chunk_generation_radius()
	_generate_chunks()
	get_viewport().connect("size_changed", self, "_on_Viewport_size_changed")
	if Global.difficulty == Global.Difficulty.HARD:
		$SyringeSpawnTimer.wait_time = 0.25
	elif Global.difficulty == Global.Difficulty.YOU_CANNOT_ESCAPE:
		$SyringeSpawnTimer.wait_time = 0.001
	start_time = OS.get_system_time_msecs()

func _on_Viewport_size_changed():
	_MobSpawnPath_set_points()
	_calculate_chunk_generation_radius()
	_generate_chunks()

func _MobSpawnPath_set_points():
	$MobSpawnPath.curve = Curve2D.new()
	$MobSpawnPath.curve.add_point(Vector2(0, 0))
	$MobSpawnPath.curve.add_point(Vector2(get_viewport().size.x, 0))
	$MobSpawnPath.curve.add_point(get_viewport().size)
	$MobSpawnPath.curve.add_point(Vector2(0, get_viewport().size.y))
	$MobSpawnPath.curve.add_point(Vector2(0, 0))

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.click_sound.play()
		get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Timer_timeout():
	var milliseconds = OS.get_system_time_msecs() - start_time
	var seconds = milliseconds / 1000
	milliseconds -= seconds * 1000
	var minutes = seconds / 60
	seconds -= minutes * 60
	$HUD/HBoxContainer/TimerLabel.text = "%02d:%02d.%03d" % [minutes, seconds, milliseconds]

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
	
	if Global.difficulty == Global.Difficulty.EASY:
		syringe.linear_velocity = Vector2(rand_range(300, 500), 0)
	elif Global.difficulty == Global.Difficulty.NORMAL:
		syringe.linear_velocity = Vector2(rand_range(400, 600), 0)
	elif Global.difficulty == Global.Difficulty.HARD:
		syringe.linear_velocity = Vector2(rand_range(700, 900), 0)
	elif Global.difficulty == Global.Difficulty.YOU_CANNOT_ESCAPE:
		syringe.linear_velocity = Vector2(rand_range(100, 200), 0)
	syringe.linear_velocity = syringe.linear_velocity.rotated(syringe.rotation)
	
	active_syringes += 1
	syringe.connect("tree_exited", self, "_on_Syringe_tree_exited")

func _check_game_over():
	if $Player.stopped and active_syringes == 0:
		$GameOverSound.play()

func _on_Syringe_tree_exited():
	active_syringes -= 1
	_check_game_over()

func _on_Player_hit_by_enemy(enemy):
	enemy.hit_player()
	if not $Player.stopped:
		$Player.stopped = true
		$Timer.stop()
		$SyringeSpawnTimer.stop()
		$HUD/GameOverTxt.show()
	active_syringes -= 1
	_check_game_over()

func _on_GameOverSoundPlayer_finished():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Player_victim_infected(victim):
	if not victim.infected:
		victim.infect()
		infected_people += 1
		$HUD/HBoxContainer/InfectedPeopleLabel.text = "Infected people:\n%d" % infected_people

func _calculate_chunk_generation_radius():
	chunk_generation_radius = Vector2(
		ceil(get_viewport().size.x / CHUNK_SIZE.x / 2),
		ceil(get_viewport().size.y / CHUNK_SIZE.y / 2)
	)

func _generate_chunks():
	var current_chunk = $Player.position
	current_chunk.x = floor(current_chunk.x / CHUNK_SIZE.x)
	current_chunk.y = floor(current_chunk.y / CHUNK_SIZE.y)
	var min_chunk = current_chunk - chunk_generation_radius
	var max_chunk = current_chunk + chunk_generation_radius
	for i in range(min_chunk.x, max_chunk.x + 1):
		for j in range(min_chunk.y, max_chunk.y + 1):
			var chunk = Vector2(i, j)
			if !generated_chunks.has(chunk):
				for _i in range(0, rand_range(1, 2)):
					var human = Human.instance()
					add_child(human)
					human.position = Vector2(
						rand_range(chunk.x*CHUNK_SIZE.x, chunk.x*CHUNK_SIZE.x+CHUNK_SIZE.x),
						rand_range(chunk.y*CHUNK_SIZE.y, chunk.y*CHUNK_SIZE.y+CHUNK_SIZE.y)
					)
				generated_chunks.append(chunk)

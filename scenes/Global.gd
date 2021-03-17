extends Node

enum Difficulty {EASY, NORMAL, HARD, INSTANT_DEATH}

var difficulty = Difficulty.NORMAL

func _ready():
	randomize()
	
	var f = File.new()
	if f.file_exists("user://settings.dat"):
		f.open("user://settings.dat", File.READ)
		difficulty = f.get_var()
		f.close()

func save_settings():
	var f = File.new()
	f.open("user://settings.dat", File.WRITE)
	f.store_var(difficulty)
	f.close()

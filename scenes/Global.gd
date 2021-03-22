extends Node

const SETTINGS_FILE_PATH = "user://settings.dat"

enum Difficulty {EASY, NORMAL, HARD, YOU_CANNOT_ESCAPE}

var difficulty = Difficulty.NORMAL

func _ready():
	randomize()
	
	var f = File.new()
	if f.file_exists(SETTINGS_FILE_PATH):
		f.open(SETTINGS_FILE_PATH, File.READ)
		difficulty = f.get_var()
		f.close()

func save_settings():
	var f = File.new()
	f.open(SETTINGS_FILE_PATH, File.WRITE)
	f.store_var(difficulty)
	f.close()

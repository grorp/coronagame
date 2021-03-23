extends Node

const SETTINGS_FILE_PATH = "user://settings.dat"

enum Difficulty {EASY, NORMAL, HARD, YOU_CANNOT_ESCAPE}
var difficulty = Difficulty.NORMAL

enum PlayerSkins {CORONA, ROBOT, RAINBOW}
var player_skin = PlayerSkins.CORONA

enum PlayerAccessoires {NOTHING, GLASSES}
var player_accessoire = PlayerAccessoires.NOTHING

func _ready():
	randomize()
	
	var f = File.new()
	if f.file_exists(SETTINGS_FILE_PATH):
		f.open(SETTINGS_FILE_PATH, File.READ)
		difficulty = f.get_var()
		player_skin = f.get_var()
		player_accessoire = f.get_var()
		f.close()

func save_settings():
	var f = File.new()
	f.open(SETTINGS_FILE_PATH, File.WRITE)
	f.store_var(difficulty)
	f.store_var(player_skin)
	f.store_var(player_accessoire)
	f.close()

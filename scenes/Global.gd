extends Node

const SETTINGS_FILE_PATH = "user://settings.dat"

enum Difficulty {EASY, NORMAL, HARD, YOU_CANNOT_ESCAPE}
var difficulty = Difficulty.NORMAL

enum PlayerSkins {CORONA, ROBOT, RAINBOW, EYE}
var PLAYER_SKIN_TEXTURES = {
	PlayerSkins.CORONA: load("res://assets/textures/virus/virus.png"),
	PlayerSkins.ROBOT: load("res://assets/textures/virus/virus_robot.png"),
	PlayerSkins.RAINBOW: load("res://assets/textures/virus/virus_rainbow.png"),
	PlayerSkins.EYE: load("res://assets/textures/virus/virus_eye.png"),
}
var player_skin = PlayerSkins.CORONA

enum PlayerAccessoires {NOTHING, GLASSES}
var PLAYER_ACCESSOIRE_TEXTURES = {
	PlayerAccessoires.NOTHING: null,
	PlayerAccessoires.GLASSES: load("res://assets/textures/virus/virus_glasses.png"),
}
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

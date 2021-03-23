extends Node

const SETTINGS_FILE_PATH = "user://settings.dat"

enum Difficulty {EASY, NORMAL, HARD, YOU_CANNOT_ESCAPE}
var difficulty = Difficulty.NORMAL

enum PlayerSkins {CORONA, ROBOT, RAINBOW, EYE}
var PLAYER_SKIN_TEXTURES = {
	PlayerSkins.CORONA: load("res://assets/textures/player/skins/corona.png"),
	PlayerSkins.ROBOT: load("res://assets/textures/player/skins/robot.png"),
	PlayerSkins.RAINBOW: load("res://assets/textures/player/skins/rainbow.png"),
	PlayerSkins.EYE: load("res://assets/textures/player/skins/eye.png"),
}
var player_skin = PlayerSkins.CORONA

enum PlayerAccessoires {NOTHING, GLASSES, MASK}
var PLAYER_ACCESSOIRE_TEXTURES = {
	PlayerAccessoires.NOTHING: null,
	PlayerAccessoires.GLASSES: load("res://assets/textures/player/accessoires/glasses.png"),
	PlayerAccessoires.MASK: load("res://assets/textures/player/accessoires/mask.png"),
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

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		get_tree().change_scene("res://scenes/ConfirmExitMenu.tscn")

extends Node

const SETTINGS_FILE_PATH = "user://settings.dat"

enum Difficulty {EASY, NORMAL, HARD, YOU_CANNOT_ESCAPE}
var difficulty = Difficulty.NORMAL

var PLAYER_SKINS = {
	"corona": load("res://assets/textures/player/skins/corona.png"),
	"robot": load("res://assets/textures/player/skins/robot.png"),
	"rainbow": load("res://assets/textures/player/skins/rainbow.png"),
	"eye": load("res://assets/textures/player/skins/eye.png"),
}
var player_skin = "corona"

var PLAYER_ACCESSOIRES = {
	"glasses": [
		load("res://assets/textures/player/accessoires/glasses.png"),
		{
			"eye": load("res://assets/textures/player/accessoires/glasses_eye.png")
		},
	],
	"mask": [
		load("res://assets/textures/player/accessoires/mask.png"),
		{
			"eye": load("res://assets/textures/player/accessoires/mask_eye.png"),
		},
	],
}
var player_accessoires = []

var click_sound = null

func _ready():
	randomize()
	
	var f = File.new()
	if f.file_exists(SETTINGS_FILE_PATH):
		f.open(SETTINGS_FILE_PATH, File.READ)
		difficulty = f.get_var()
		player_skin = f.get_var()
		player_accessoires = f.get_var()
		f.close()
	
	click_sound = AudioStreamPlayer.new()
	click_sound.stream = load("res://assets/sounds/click.ogg")
	add_child(click_sound)

func save_settings():
	var f = File.new()
	f.open(SETTINGS_FILE_PATH, File.WRITE)
	f.store_var(difficulty)
	f.store_var(player_skin)
	f.store_var(player_accessoires)
	f.close()

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		get_tree().change_scene("res://scenes/ConfirmExitMenu.tscn")

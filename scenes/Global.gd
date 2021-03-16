extends Node

func _ready():
	randomize()

enum Difficulty {EASY, NORMAL, HARD}

var difficulty = Difficulty.NORMAL

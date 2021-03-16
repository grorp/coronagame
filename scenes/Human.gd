extends StaticBody2D

var infected = false

func infect():
	infected = true
	$AnimationPlayer.play("infect")

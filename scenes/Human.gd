extends KinematicBody2D

var infected = false

func infect():
	infected = true
	$AnimationPlayer.play("disappear")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "disappear":
		queue_free()

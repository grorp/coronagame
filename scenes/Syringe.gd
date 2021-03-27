extends RigidBody2D

func hit_player():
	linear_velocity = Vector2(0, 0)
	$PlayerHitSound.play()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

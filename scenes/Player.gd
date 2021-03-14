extends Area2D

const speed = 300

signal dead
var dead = false

func _physics_process(delta):
	if dead:
		return
	
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta

func _on_body_entered(body):
	if body.is_in_group("enemy") and !dead:
		dead = true
		emit_signal("dead", body)

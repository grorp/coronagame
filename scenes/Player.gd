extends Area2D

var speed = 300
var stopped = false

signal hit_by_enemy
signal victim_infected
signal moved

func _ready():
	if Global.difficulty == Global.Difficulty.HARD:
		speed = 500
	
	if Global.player_skin == Global.PlayerSkins.ROBOT:
		$Sprite.texture = load("res://assets/textures/virus/virus_robot.png")
	elif Global.player_skin == Global.PlayerSkins.RAINBOW:
		$Sprite.texture = load("res://assets/textures/virus/virus_rainbow.png")
	
	if Global.player_accessoire == Global.PlayerAccessoires.GLASSES:
		$AccessoireSprite.texture = load("res://assets/textures/virus/virus_glasses.png")

func _physics_process(delta):
	if stopped:
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
		emit_signal("moved")

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("hit_by_enemy", body)
	elif body.is_in_group("victim"):
		emit_signal("victim_infected", body)

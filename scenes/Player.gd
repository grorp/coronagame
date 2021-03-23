extends Area2D

var speed = 300
var stopped = false

signal hit_by_enemy
signal victim_infected
signal moved

func _ready():
	if Global.difficulty == Global.Difficulty.HARD:
		speed = 500
	
	$Sprite.texture = Global.PLAYER_SKINS[Global.player_skin]
	for accessoire in Global.player_accessoires:
		var sprite = Sprite.new()
		sprite.texture = Global.PLAYER_ACCESSOIRES[accessoire]
		sprite.scale = Vector2(3, 3)
		add_child(sprite)

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

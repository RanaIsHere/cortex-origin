extends KinematicBody2D

var velocity = Vector2.ZERO
var treecollider = null

func _ready():
	$AnimatedSprite.animation = "idle-unclothed"

func get_input(var delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		#$AnimatedSprite.flip_v = true
		rotation_degrees = 180
	if Input.is_action_pressed("down"):
		velocity.y += 1
		#$AnimatedSprite.flip_v = false
		rotation_degrees = 0
	if Input.is_action_pressed("right"):
		velocity.x += 1
		rotation_degrees = -90
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		rotation_degrees = 90
		
	if Input.is_action_just_pressed("interact"): # Break, Use
		if treecollider != null:
			treecollider.durability -= 1
			treecollider.get_node_or_null("axeSound").playing = true
			print(treecollider.durability)
		
	if velocity != Vector2.ZERO:
		if Globals.playerEquipment == "unclothed":
			$AnimatedSprite.animation = "walk-unclothed"
		elif Globals.playerEquipment == "labcoat":
			$AnimatedSprite.animation = "walk-labcoat"
	else:
		if Globals.playerEquipment == "unclothed":
			$AnimatedSprite.animation = "idle-unclothed"
		elif Globals.playerEquipment == "labcoat":
			$AnimatedSprite.animation = "idle-labcoat"
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * Globals.playerSpeed, velocity)
	
func _physics_process(delta):
	if Globals.canMove == true:
		get_input(delta)

func _on_rangeArea_body_entered(body):
	if body.is_in_group("trees"):
		body.allowMined = true
		treecollider = body
		#print(body.allowMined)
		


func _on_rangeArea_body_exited(body):
	if body.is_in_group("trees"):
		body.allowMined = false
		treecollider = null
		#print(body.allowMined)

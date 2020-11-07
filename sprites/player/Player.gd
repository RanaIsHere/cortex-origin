extends KinematicBody2D

var velocity = Vector2.ZERO
var treecollider = null
var isInventory = false
var isCrafting = false
var isUpgrading = false

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
			if treecollider.allowMined == true:
				treecollider.durability -= 1
				treecollider.get_node_or_null("axeSound").playing = true
		
		if Globals.aboveTileMap != null:
			if Globals.harvestMode == true:
				if Globals.aboveTileMap == 0:
					$PGUI/PlayerInventory.addItem(0, true)
					# Sieve grass from ground and spawn it below the player.
				
	if Input.is_action_just_pressed("inventory"):
		if isInventory == false:
			isInventory = true
			$PGUI/PlayerInventory.visible = true
			return
		if isInventory == true:
			isInventory = false
			$PGUI/PlayerInventory.visible = false	
			return
			
	if Input.is_action_just_pressed("craft"):
		if isCrafting == false:
			isCrafting = true
			$PGUI/PlayerCrafting.visible = true
			return
		if isCrafting == true:
			isCrafting = false
			$PGUI/PlayerCrafting.visible = false	
			return
	
	if Input.is_action_just_pressed("upgrade"):
		if isUpgrading == false:
			isUpgrading = true
			$PGUI/PlayerUpgrade.visible = true
			return
		if isUpgrading == true:
			isUpgrading = false
			$PGUI/PlayerUpgrade.visible = false	
			return
	
	
	if treecollider != null:
		if treecollider.isBreak == true:
			if $pickUp.playing == false:
				$pickUp.playing = true
			
			Globals.wood += treecollider.woodYield
			treecollider.queue_free()
				
				
	if velocity != Vector2.ZERO:
		if Globals.playerEquipment == "unclothed":
			$AnimatedSprite.animation = "walk-unclothed"
		elif Globals.playerEquipment == "labcoat":
			$AnimatedSprite.animation = "walk-labcoat"
			
		match Globals.isWalkingOn:
			"grass":
				if $grassWalkSound.is_playing() == false:
					$grassWalkSound.playing = true
			"metal":
				if $grassWalkSound.is_playing() == true: #Precaution
					$grassWalkSound.playing = false
			"water":
				if $grassWalkSound.is_playing() == true: #Precaution
					$grassWalkSound.playing = false
	else:
		if Globals.playerEquipment == "unclothed":
			$AnimatedSprite.animation = "idle-unclothed"
		elif Globals.playerEquipment == "labcoat":
			$AnimatedSprite.animation = "idle-labcoat"
		
		match Globals.isWalkingOn:
			"grass":
				if $grassWalkSound.is_playing() == true:
					$grassWalkSound.playing = false
			"metal":
				if $grassWalkSound.is_playing() == true: #Precaution
					$grassWalkSound.playing = false
			"water":
				if $grassWalkSound.is_playing() == true: # Precaution
					$grassWalkSound.playing = false
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * Globals.playerSpeed, velocity)
	
func _physics_process(delta):
	if Globals.canMove == true:
		get_input(delta)
	
	if Globals.isIntro == false:
		if Globals.playerTemperature > 61:
			if Globals.playerHunger > 0:
				Globals.playerHunger -= 0.01 / 4
			if Globals.playerThirst > 0:
				Globals.playerThirst -= 0.01 / 2
			#print("hot")
		elif Globals.playerTemperature < 39:
			if Globals.playerHunger > 0:
				Globals.playerHunger -= 0.01 / 2
			if Globals.playerThirst > 0:
				Globals.playerThirst -= 0.01 / 4
			#print("cold")
		else:
			if Globals.playerHunger > 0:
				Globals.playerHunger -= 0.01 / 10
			if Globals.playerThirst > 0:
				Globals.playerThirst -= 0.01 / 8
			
			#print("normal")
			
		if Globals.playerThirst < 0:
			Globals.playerThirst = 0
		if Globals.playerHunger < 0:
			Globals.playerHunger = 0
		
		if Globals.playerThirst <= 0 or Globals.playerHunger <= 0:
			Globals.playerHealth -= 1
			
		#print(Globals.playerHunger)
	
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

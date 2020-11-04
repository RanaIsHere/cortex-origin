extends Control

var mainResourcePick = 0

func _ready():
	$Wood.visible = false
	$Metal.visible = false
	$Meat.visible = false

func _process(_delta):
	#$HealthBar.value = Globals.playerHealth
	
	if Globals.playerHealth < $HealthBar.value:
		$HealthBar.value -= 1
		
	if Globals.playerHunger < $HungerBar.value:
		$HungerBar.value -= 0.2
		
	if Globals.playerHunger < $ThirstBar.value:
		$ThirstBar.value -= 0.2
		
	$Wood/WoodLabel.text = "Wood: " + str(Globals.wood)
	$Metal/MetalLabel.text = "Metal: " + str(Globals.metal)
	$Meat/MeatLabel.text = "Meat: " + str(Globals.rawMeat)
	
	if Input.is_action_just_pressed("hotbarMain"):
		mainResourcePick += 1
		
		if mainResourcePick > 2:
			mainResourcePick = 0
	
	match mainResourcePick:
		0:
			$Wood.visible = true
			$Metal.visible = false
			$Meat.visible = false
		1:
			$Metal.visible = true
			$Wood.visible = false
			$Meat.visible = false
		2:
			$Meat.visible = true
			$Metal.visible = false
			$Wood.visible = false
		

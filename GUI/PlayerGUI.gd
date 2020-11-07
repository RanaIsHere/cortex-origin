extends Control

var mainResourcePick = 0

func _ready():
	$MainResPanel/Wood.visible = false
	$MainResPanel/Metal.visible = false
	$MainResPanel/Meat.visible = false

func _process(_delta):
	#$HealthBar.value = Globals.playerHealth
	
	if Globals.playerHealth < $HealthBar.value:
		$HealthBar.value -= 1
	if Globals.playerHealth > $HealthBar.value:
		$HealthBar.value += 1
		
	if Globals.playerHunger < $HungerBar.value:
		$HungerBar.value -= 0.01
	if Globals.playerHunger > $HungerBar.value:
		$HungerBar.value += 0.01
		
	if Globals.playerHunger < $ThirstBar.value:
		$ThirstBar.value -= 0.01
	if Globals.playerHunger > $ThirstBar.value:
		$ThirstBar.value += 0.01	
			
	if Globals.playerTemperature < $TemperatureBar.value:
		$TemperatureBar.value -= 1	
	if Globals.playerTemperature > $TemperatureBar.value:
		$TemperatureBar.value += 1
		
	if Globals.playerAnomaly < $AnomalyBar.value:
		$AnomalyBar.value -= 1
	if Globals.playerAnomaly > $AnomalyBar.value:
		$AnomalyBar.value += 1
	
	$MainResPanel/Wood/WoodLabel.text = "Wood: " + str(Globals.wood)
	$MainResPanel/Metal/MetalLabel.text = "Metal: " + str(Globals.metal)
	$MainResPanel/Meat/MeatLabel.text = "Meat: " + str(Globals.rawMeat)
	
	if Input.is_action_just_pressed("hotbarMain"):
		mainResourcePick += 1
		
		if mainResourcePick > 2:
			mainResourcePick = 0
	
	if Input.is_action_just_pressed("harvest"):
		if Globals.harvestMode == false:
			Globals.harvestMode = true
			$MainResPanel/HarvestMode.text = "Harvest Mode: On"
			return
			
		if Globals.harvestMode == true:
			Globals.harvestMode = false
			$MainResPanel/HarvestMode.text = "Harvest Mode: Off"
			return
		
	#print(Globals.harvestMode)
	
	match mainResourcePick:
		0:
			$MainResPanel/Wood.visible = true
			$MainResPanel/Metal.visible = false
			$MainResPanel/Meat.visible = false
		1:
			$MainResPanel/Metal.visible = true
			$MainResPanel/Wood.visible = false
			$MainResPanel/Meat.visible = false
		2:
			$MainResPanel/Meat.visible = true
			$MainResPanel/Metal.visible = false
			$MainResPanel/Wood.visible = false
		

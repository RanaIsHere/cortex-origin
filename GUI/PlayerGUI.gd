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
	
	$Wood/WoodLabel.text = "Wood: " + str(Globals.wood)
	$Metal/MetalLabel.text = "Metal: " + str(Globals.metal)
	$Meat/MeatLabel.text = "Meat: " + str(Globals.rawMeat)
	
	if Input.is_action_just_pressed("hotbarMain"):
		mainResourcePick += 1
		
		if mainResourcePick > 2:
			mainResourcePick = 0
	
	if Input.is_action_just_pressed("harvest"):
		if Globals.harvestMode == false:
			Globals.harvestMode = true
			$HarvestMode.text = "Harvest Mode: On"
			return
			
		if Globals.harvestMode == true:
			Globals.harvestMode = false
			$HarvestMode.text = "Harvest Mode: Off"
			return
		
	#print(Globals.harvestMode)
	
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
		

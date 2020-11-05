extends Node2D

var treeInst = preload("res://sprites/object/ForestTree.tscn")
var forestTemp = 50

func _ready():
	Globals.playerTemperature = forestTemp
	Globals.canMove = true
	Globals.isIntro = false
	
	$worldMap/Forests.visible = true
	$worldMap/Forests2.visible = true
	
	if Globals.isFirstDoor == true:
		$worldMap.set_cellv(Vector2(14, 11), 0)
		$worldMap.set_cellv(Vector2(13, 11), 0)
		$worldMap.set_cellv(Vector2(12, 11), 0)
	
	randomize()

func _process(delta):
	var tm = $worldMap.world_to_map($Player.global_position)
	var tl = $worldMap.get_cellv(Vector2(tm.x, tm.y))
	Globals.aboveTileMap = tl
	
	if get_tree().get_nodes_in_group("trees").size() < 250:
		forestTemp = 60
	else:
		forestTemp = 50
		
	if tl == 6:
		Globals.playerSpeed = 100
		Globals.playerTemperature = 35
	else:
		Globals.playerSpeed = 200
		Globals.playerTemperature = forestTemp
	
	
	
	
func _on_checker_body_entered(body):
	if body.name == "Player":
		Globals.playerEquipment = "unclothed"
		
		$worldMap/checker.queue_free()


func _on_doorOpener_body_entered(body):
	if body.name == "Player":
		if Globals.isFirstDoor == false:
			Globals.playerEquipment = "unclothed"
			$worldMap.set_cellv(Vector2(14, 11), 0)
			$worldMap.set_cellv(Vector2(13, 11), 0)
			$worldMap.set_cellv(Vector2(12, 11), 0)
			Globals.isFirstDoor = true
		
			$worldMap/doorOpener.queue_free()


func _on_Forests_body_entered(body):
	if body.name == "Player":
		$worldMap/Forests.visible = true
		Globals.playerTemperature = forestTemp

func _on_Forests_body_exited(body):
	if body.name == "Player":
		$worldMap/Forests.visible = false
		Globals.playerTemperature = 50


func _on_Forests2_body_entered(body):
	if body.name == "Player":
		$worldMap/Forests2.visible = true
		Globals.playerTemperature = forestTemp


func _on_Forests2_body_exited(body):
	if body.name == "Player":
		$worldMap/Forests2.visible = false
		Globals.playerTemperature = 50

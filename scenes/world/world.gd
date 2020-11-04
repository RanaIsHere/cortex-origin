extends Node2D

var treeInst = preload("res://sprites/object/ForestTree.tscn")

func _ready():
	Globals.playerTemperature = 16
	Globals.canMove = true
	Globals.isIntro = false
	
	if Globals.isFirstDoor == true:
		$worldMap.set_cellv(Vector2(14, 11), 0)
		$worldMap.set_cellv(Vector2(13, 11), 0)
		$worldMap.set_cellv(Vector2(12, 11), 0)
	
	randomize()

func _process(delta):
	var tm = $worldMap.world_to_map($Player.global_position)
	var tl = $worldMap.get_cellv(Vector2(tm.x, tm.y)) 
	
	if get_tree().get_nodes_in_group("trees").size() < 24:
		var t = treeInst.instance()
		
		$worldMap/Tree.add_child(t)
		t.add_to_group("trees")
		
		var treeMap = $worldMap.world_to_map(t.position)
		var tileTree = $worldMap.get_cellv(Vector2(treeMap.x, treeMap.y))
		
		if tileTree == -1 and tileTree == 2 and tileTree == 3 and tileTree == 4 and tileTree == 5: 
			t.position = Vector2(randi() % 1024, randi() % 768)
		else:
			t.position = Vector2(randi() % 1024, randi() % 768)
			
	

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



func _on_Tree_body_entered(body):
	if body.name == "Player":
		print(get_tree().get_nodes_in_group("trees").size())
		#if get_tree().get_nodes_in_group("trees").size() != 30:
			#var t = treeInst.instance()
			
			#$worldMap/Tree.add_child(t)
			#t.position = Vector2(randi() % 784, randi() % 701)
			

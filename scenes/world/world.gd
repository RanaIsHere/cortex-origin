extends Node2D

func _ready():
	Globals.playerTemperature = 16

func _process(delta):
	var tm = $worldMap.world_to_map($Player.global_position)
	var tl = $worldMap.get_cellv(Vector2(tm.x, tm.y)) 
	

func _on_checker_body_entered(body):
	if body.name == "Player":
		Globals.playerEquipment = "unclothed"
		
		$worldMap/checker.queue_free()


func _on_doorOpener_body_entered(body):
	if body.name == "Player":
		Globals.playerEquipment = "unclothed"
		$worldMap.set_cellv(Vector2(14, 11), 0)
		$worldMap.set_cellv(Vector2(13, 11), 0)
		$worldMap.set_cellv(Vector2(12, 11), 0)
		
		$worldMap/doorOpener.queue_free()


extends Area2D

var allowPickup = false


func _ready():
	position.y += 50
	allowPickup = false

func _on_pickupArea_body_entered(body):
	if body.name == "Player" and allowPickup == true:
		if body.get_node_or_null("pickUp").playing == false:
			body.get_node_or_null("pickUp").playing = true
		
		if Globals.pickBuffer.has("Grass"):
			if Globals.pickBuffer["Grass"] != 300: # Limits of items that can be picked up, unintentional.
				Globals.pickBuffer["Grass"] += 1
				Globals.droppedItemArray.append("Grass")
				print(Globals.droppedItemArray)
				allowPickup = false
				#queue_free()
		
		queue_free()

func _on_pickupArea_body_exited(body):
	allowPickup = true

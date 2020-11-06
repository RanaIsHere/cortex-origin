extends RigidBody2D

var allowPickup = false

func _ready():
	allowPickup = false
	linear_velocity = Vector2(5, 0)
	position.x += 20

func _on_pickupArea_body_entered(body):
	if body.name == "Player" and allowPickup == true:
		if body.get_node_or_null("pickUp").playing == false:
			body.get_node_or_null("pickUp").playing = true
		
		#Globals.pickBuffer["Grass"] += 1
		
		queue_free()


func _on_cooldown_timeout():
	allowPickup = true

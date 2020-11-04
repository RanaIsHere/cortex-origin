extends StaticBody2D

var allowMined = false
var durability = 3
var woodYield = randi() % 3 + 1

func _ready():
	randomize()

func _process(_delta):
	if allowMined == true:			
		if durability == 0 or durability < 0:
			yield($axeSound, "finished")
			
			queue_free()
	
func _on_shade_body_entered(body):
	if body.name == "Player":
		$body/head.modulate = Color(1,1,1, 0.5)


func _on_shade_body_exited(body):
	if body.name == "Player":
		$body/head.modulate = Color(1,1,1, 1)

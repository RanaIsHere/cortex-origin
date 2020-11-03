extends Node2D

var isSceneComplete = false
var isCutscene = false
var a = -1
var year = 2020

func _ready():
	$Player.global_position = $Position2D.global_position
	Globals.isIntro = true
	Globals.playerTemperature = 14
	$Machine/CollisionShape2D.set_deferred("disabled", true)
	$Precaution.start()
	
func _process(delta):
	if isCutscene == true:
		Globals.canMove = false
	
	$GUI/Control/Label.text = "Year: " + str(year)
	
	if a == 0:
		if year > 1980:
			year -= 1
	if a == 1:
		if year > 0:
			year -= 15
	
func _on_Machine_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("movePlayer")
		isCutscene = true
		$Player/AnimatedSprite.animation = "walk-labcoat"
		$Player.rotation_degrees = 0


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "movePlayer":
		$Player/AnimatedSprite.animation = "idle-labcoat"
		$Start.start()
		
	if anim_name == "disappear":
		$AudioStreamPlayer.playing = true
		
		yield($AudioStreamPlayer, "finished")
		
		get_tree().change_scene("res://scenes/world/world.tscn")
	
func _on_Start_timeout():
	$Machine/TimeMachine.speed_scale = 0.5
	a = 0
	$End.start()


func _on_End_timeout():
	$Machine/TimeMachine.speed_scale = 4
	$Machine.modulate = Color(0.98, 0.617, 0.9, 1)
	a = 1
	$Change.start()


func _on_Change_timeout():
	$AnimationPlayer.play("disappear")


func _on_Precaution_timeout():
	$Machine/CollisionShape2D.set_deferred("disabled", false)

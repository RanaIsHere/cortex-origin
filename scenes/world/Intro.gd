extends Node2D

var isSceneComplete = false
var isCutscene = false
var a = false
var c = 1
var b = false

func _ready():
	$Player.global_position = $Position2D.global_position
	Globals.isIntro = true
	Globals.playerTemperature = 14
	$Machine/CollisionShape2D.set_deferred("disabled", true)
	$Precaution.start()
	
func _process(delta):
	if isCutscene == true:
		Globals.canMove = false
	
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
		get_tree().change_scene("")
	
func _on_Start_timeout():
	$Machine/TimeMachine.speed_scale = 0.5
	$End.start()


func _on_End_timeout():
	$Machine/TimeMachine.speed_scale = 4
	$Change.start()


func _on_Change_timeout():
	$AnimationPlayer.play("disappear")


func _on_Precaution_timeout():
	$Machine/CollisionShape2D.set_deferred("disabled", false)

extends Control

func _ready():
	$CraftingPanel/CraftingLabel/CraftingMenu/AgeZero.visible = false
	$CraftingPanel/CraftingLabel/ItemPanel.visible = false
	
func _on_AgeButtonZero_pressed():
	$CraftingPanel/CraftingLabel/CraftingMenu/AgeZero.visible = true

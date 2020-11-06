extends Control

onready var inv = $InventoryPanel/InnerInventory/InventoryList
onready var hb = $InventoryPanel/Hotbar/HotbarList
var itemIcon : Array = ["res://GUI/inventory/icon/grassIcon.png"]
var itemInstance : Dictionary = {"Grass": preload("res://GUI/inventory/droppedItem/itemGrass.tscn")}
#var itemGrass = preload("res://GUI/inventory/droppedItem/itemGrass.tscn")
var hotbarIcon : Array = []
var selectedId = null

func _ready():
	addItem(0, true)
	#pass
	
func _process(delta):
	#if Globals.pickBuffer["Grass"] != 0 or Globals.pickBuffer["Grass"] != -1:
	#	addItem(0, true)
	#	Globals.pickBuffer["Grass"] -= 1
	##	
	#if Globals.pickBuffer["Grass"] == -1:
	#	Globals.pickBuffer["Grass"] = 0
	pass
	
func addItem(var id : int, var sel : bool) -> void:
	if getItemCount() != 51:
		var icon = load(itemIcon[id])
		inv.add_item(str(Globals.inventory[id]), icon, sel)

func addHotbar(var id : int, var sel : bool) -> void:
	if getHotbarCount() != 16:
		var icon = load(hotbarIcon[id])
		hb.add_item(str(Globals.itemHotbar[id]), icon, sel)

func removeItem(var id : int) -> void:
	if Globals.dropBuffer[getItemId(id)] != 0:
		var g = itemInstance.get(getItemId(id)).instance()
		get_parent().get_parent().get_parent().add_child(g)
		g.position = get_parent().get_parent().get_parent().get_node("Player").position
		Globals.dropBuffer[getItemId(id)] -= 1
		Globals.pickBuffer[getItemId(id)] = 0
		
		if Globals.dropBuffer[getItemId(id)] == 0:
			Globals.dropBuffer.erase(getItemId(id))


func getItemId(var id : int) -> String: # Can only run when selectedID is not NULL
	var nameOfItem
		
	nameOfItem = inv.get_item_text(id)
	
	return nameOfItem

func getItemCount() -> int:
	var a = inv.get_item_count()
	
	return a

func getHotbarCount() -> int:
	var b = hb.get_item_count()
	
	return b

func _on_InventoryList_item_selected(index):
	selectedId = index
	#print(selectedId)


func _on_InventoryList_nothing_selected():
	if selectedId != null:
		inv.unselect(selectedId)
		selectedId = null
		print(selectedId)

func _on_InventoryList_item_rmb_selected(index, at_position):
	if selectedId != null:
		var dropValue = 1
		Globals.dropBuffer[getItemId(selectedId)] = dropValue
		removeItem(selectedId)
		inv.remove_item(selectedId)
		selectedId = null
		print(Globals.dropBuffer)

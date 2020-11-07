extends Control

onready var inv = $InventoryPanel/InnerInventory/InventoryList
var itemIcon : Array = ["res://GUI/inventory/icon/grassIcon.png"]
var itemInstance : Dictionary = {"Grass": preload("res://GUI/inventory/droppedItem/itemGrass.tscn")}
var selectedId = null

func _ready():
	pass
	
func _process(delta):
	if !Globals.pickBuffer.empty():
		pickUpItem()
		
func pickUpItem() -> void:
	#if Globals.pickBuffer.size() > 0:
	for items in Globals.pickBuffer.keys():
		var id = checkItemId(items)
		if Globals.droppedItemArray.has(items):
			addItem(id, true)
			if Globals.pickBuffer[items] != 0:
				Globals.pickBuffer[items] -= 1
				Globals.droppedItemArray.erase(items)
			#if Globals.pickBuffer[items] > -1:
			#	Globals.pickBuffer.erase(items)
				id = null
				print(Globals.pickBuffer.values())	
	
func checkItemId(var keys) -> int:
	var id = null
	
	id = Globals.inventory.find(keys)
	
	return id
	
func addItem(var id : int, var sel : bool) -> void:
	if getItemCount() != 51:
		var icon = load(itemIcon[id])
		inv.add_item(str(Globals.inventory[id]), icon, sel)

#func addHotbar(var id : int, var sel : bool) -> void:
#	if getHotbarCount() != 16:
#		var icon = load(hotbarIcon[id])
#		hb.add_item(str(Globals.itemHotbar[id]), icon, sel)

func removeItem(var id : int) -> void:
	if Globals.dropBuffer[getItemId(id)] != 0:
		var g = itemInstance.get(getItemId(id)).instance()
		get_parent().get_parent().get_parent().add_child(g)
		g.transform = get_parent().get_parent().get_parent().get_node("Player").transform
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

func _on_InventoryList_item_selected(index):
	selectedId = index
	#print(selectedId)


func _on_InventoryList_nothing_selected():
	if selectedId != null:
		inv.unselect(selectedId)
		selectedId = null
		print(selectedId)

func _on_InventoryList_item_rmb_selected(_index, _at_position):
	if selectedId != null:
		if inv.is_selected(selectedId):
			var dropValue = 1
			Globals.dropBuffer[getItemId(selectedId)] = dropValue
			removeItem(selectedId)
			inv.remove_item(selectedId)
			selectedId = null

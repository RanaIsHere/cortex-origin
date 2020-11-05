extends Control

onready var inv = $InventoryPanel/InnerInventory/InventoryList
onready var hb = $InventoryPanel/Hotbar/HotbarList
var itemIcon : Array = ["res://GUI/inventory/icon/grassIcon.png"]
var hotbarIcon : Array = []
var selectedId = null

func _ready():
	pass
	
func _process(delta):
	pass
	
func addItem(var id : int, var sel : bool) -> void:
	if getItemCount() != 51:
		var icon = load(itemIcon[id])
		inv.add_item(str(Globals.inventory[id]), icon, sel)

func addHotbar(var id : int, var sel : bool) -> void:
	if getHotbarCount() != 16:
		var icon = load(hotbarIcon[id])
		hb.add_item(str(Globals.itemHotbar[id]), icon, sel)

func removeItem() -> void:
	inv.remove_item(selectedId)

func getItemCount() -> int:
	var a = inv.get_item_count()
	
	return a

func getHotbarCount() -> int:
	var b = hb.get_item_count()
	
	return b

func _on_InventoryList_item_selected(index):
	selectedId = index

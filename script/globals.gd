extends Node

# Inventory System
var inventory : Array = ["Grass", "Stone", "Dirt", "Rock"]
var dropBuffer : Dictionary = {}
var pickBuffer : Dictionary = {}

var wood : int = 0
var metal : int = 0
var rawMeat : int = 0

var droppedItemArray : Array = []

# Tools System
var toolDmg : Array = ["Spear", "Knife", "Sword", "Staves", "Musket", "Cannon", "Revolver", "Handgun"]
# Spear and Knife are Age Zero items, Sword and Staves are Age One items, Musket and Cannon are Age Two items, and Revolver and Handgun are Age Three items. They're craftable depending on the technology tier of the player.
var toolUsage : Array = ["Rock", "Sharpened Flint", "Axe", "Pickaxe", "Hoe", "Drill"]
# Rock and Sharpened Flint are Age Zero items. Axe, Pickaxe, Hoe are Age One items that can be extended to the end of age. Drill is a singular item from Age Three.


# Player
var playerHealth = 100
var playerThirst = 50
var playerHunger = 50
var playerAnomaly = 0

var playerTemperature = 50

var playerEquipment = "labcoat"

var playerSpeed = 200
var canMove = true
var isIntro = false
var isWalkingOn : String = "Metal"

var harvestMode = false

# World
var isFirstDoor : bool = false
var aboveTileMap = null

var currentAge : int = 0

extends Node

# Inventory System
var inventory : Array = ["Grass", "Stone", "Dirt", "Rock"]
var itemHotbar : Array = ["Sword", "Pickaxe"]
var wood : int = 0
var metal : int = 0
var rawMeat : int = 0

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

var harvestMode = false

# World
var isFirstDoor : bool = false
var aboveTileMap = null

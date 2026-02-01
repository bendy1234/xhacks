extends Node2D

var mine = load("res://scenes/mine.tscn")
var map = load("res://scenes/map.tscn")
var town = load("res://scenes/town.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	add_child(mine.instantiate())
	WorldManager.enter_town($Player)
	

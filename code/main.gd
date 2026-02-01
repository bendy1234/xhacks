extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WorldManager.init_game()
	WorldManager.enter_mine(1)

extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WorldManager.player = $Player
	WorldManager.enter_town()
	WorldManager.player.position = Vector2i(24, 300)

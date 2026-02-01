extends Node2D

@export
var building_type: BuildingType = BuildingType.SHOP

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter_door"):
		for thing in $door.get_overlapping_bodies():
			if thing is Player:
				on_enter()

func on_enter():
	if building_type == BuildingType.MINE_ENTRANCE:
		WorldManager.enter_mine(1)
	elif building_type == BuildingType.SHOP:
		pass
	elif building_type == BuildingType.TOWNHALL:
		pass
	elif building_type == BuildingType.INN:
		pass

enum BuildingType {
	TOWNHALL,
	SHOP,
	INN,
	MINE_ENTRANCE,
}

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
		var c = 0
		for i in range(WorldManager.player.inv.items.size()):
			if WorldManager.player.inv.items[i] == null:
				continue
			
			c += ore_prices.get(WorldManager.player.inv.items[i], 0)
			WorldManager.player.inv.items[i] = null	
		WorldManager.player.coins += c
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

var ore_prices = {
	"coal_ore": 1,
	"iron_ore": 3,
	"gold_ore": 7
}

extends Node2D

const shop_overlay = preload("res://scenes/shop.tscn")
var inst: Node2D

@export
var building_type: BuildingType = BuildingType.Trade

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter_door") and inst == null:
		for thing in $door.get_overlapping_bodies():
			if thing is Player:
				on_enter()
	elif event.is_action_pressed("esc"):
		if inst != null:
			WorldManager.player.allow_movement = true
			remove_child.call_deferred(inst)
			inst = null

func on_enter():
	if building_type == BuildingType.MINE_ENTRANCE:
		WorldManager.enter_mine(1)
	else:
		inst = shop_overlay.instantiate()
		inst.shop_type = building_type
		add_child(inst)
		inst.global_position = Vector2i(540, 360) / 2
		WorldManager.player.allow_movement = false


enum BuildingType {
	Trade,
	Mine,
	O2,
	Water,
	MINE_ENTRANCE
}

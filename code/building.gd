extends Node2D

var building_type = SHOP

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter_door"):
		for thing in $door.get_overlapping_bodies():
			if thing is Player:
				on_enter()

func on_enter():
	print("door entered")

enum {
	TOWNHALL,
	SHOP,
	INN,
	MINE_ENTRANCE,
}

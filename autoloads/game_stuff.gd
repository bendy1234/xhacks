extends Node

var rent_time = 1 * 60
var time_till_rent = rent_time
var rent_amount = 40

func _physics_process(delta: float) -> void:
	time_till_rent -= delta
	if time_till_rent <= 0:
		rent_time *= 1.2
		rent_amount *= 1.5
		time_till_rent = rent_time
		WorldManager.player.coins -= rent_amount
		if WorldManager.player.coins < 0:
			WorldManager.player.allow_movement = false
			WorldManager.player.collision_mask = 0
			WorldManager.player.collision_layer = 0
			get_tree().change_scene_to_file("res://scenes/gameover.tscn")

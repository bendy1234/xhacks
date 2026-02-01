extends Node

var rent_time = 5 * 60
var time_till_rent = rent_time
var rent_amount = 10

func _physics_process(delta: float) -> void:
	time_till_rent -= delta
	if time_till_rent <= 0:
		rent_time *= 1.2
		rent_amount *= 1.5
		time_till_rent = rent_time
		WorldManager.player.coins -= rent_amount
		if WorldManager.player.coins < 0:
			print("gameover")

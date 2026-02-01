extends Node

func format_time(seconds: float) -> String:
	var minutes = int(seconds / 60)
	var secs = int(seconds) % 60
	return "%02d:%02d" % [minutes, secs]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$time.text = format_time(GameStuff.time_till_rent)
	$coins.text = "Coins: %d" % WorldManager.player.coins

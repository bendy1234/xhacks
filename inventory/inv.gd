extends Sprite2D

func _input(event):
	if event.is_action_pressed("open_inventory"):
		visible = !visible
		update()
			
func _ready():
	visible = false

func update():
	$gold.text = "%d" % WorldManager.player.inv["gold_ore"]
	$iron.text = "%d" % WorldManager.player.inv["iron_ore"]
	$coal.text = "%d" % WorldManager.player.inv["coal_ore"]

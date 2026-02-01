extends Node2D

enum TileType {
	STONE = 0,
	COAL = 3,
	IRON = 4,
	GOLD = 5,
	GATE = 6,
	BG = 7
}

@onready
var tilemap: TileMapLayer = $TileMapLayer
@onready
var block_breaking: Sprite2D = $block_breaking
var id: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("enter_door"):
		var player = WorldManager.player
		var pos = to_tile_cords(player.position)
		# this code gets more and more jank as time goes on
		if pos.x <= 2 and pos.y <= 2:
			WorldManager.enter_mine(player.area_num + 1)
		elif pos.x >= 24 and pos.y <= 2:
			if player.area_num == 1:
				WorldManager.enter_town()
				WorldManager.player.position = Vector2i(614, 300)
			else:
				WorldManager.enter_mine(player.area_num - 1, 1)

func get_data() -> PackedByteArray:
	return tilemap.tile_map_data

func set_data(tile_map_data: PackedByteArray):
	tilemap.tile_map_data = tile_map_data

func set_default():
	# 1,3 -> 25, 13
	# 24, 10
	for i in range(1, 26):
		for j in range(3, 14):
			var num = randf()
			if num <= 0.05:
				tilemap.set_cell(Vector2i(i, j), TileType.GOLD, Vector2i(0, 0))
			elif num <= 0.14:
				tilemap.set_cell(Vector2i(i, j), TileType.IRON, Vector2i(0, 0))
			elif num < 0.25:
				tilemap.set_cell(Vector2i(i, j), TileType.COAL, Vector2i(0, 0))
			else:
				tilemap.set_cell(Vector2i(i, j), TileType.STONE, Vector2i(0, 0))
	
	tilemap.set_cell(Vector2i(1, 3))
	tilemap.set_cell(Vector2i(2, 3))
	tilemap.set_cell(Vector2i(24, 3))
	tilemap.set_cell(Vector2i(25, 3))
	
	#var x = randi() % 20
	#var y = randi() % 11
	#
	#tilemap.set_cell(Vector2i(x, y), 1, Vector2i(0, 0))
	#
	#while true:
		#var x_ = randi() % 20
		#var y_ = randi() % 11
		#if (x == x_ and y == y_):
			#continue
		#
		#tilemap.set_cell(Vector2i(x_, y_), 2, Vector2i(0, 0))
		#break
	

# this just returns the entrance/exit of the cave
func find_tile(tile: int) -> Vector2i:
	if tile == 1:
		return Vector2i(1, 2)
	return Vector2i(24, 2)
	## 1 is down 2 is up
	#for i in range(22):
		#for j in range(13):
			#var c = tilemap.get_cell_source_id(Vector2i(i-1, j-1))
			#if c == tile:
				#return Vector2i(i-1, j-1)
#
	## should not happen but can
	#print("Did not find tile with id ", tile)
	#return Vector2i(-100, -100)

func get_break_time(pos: Vector2i) -> float:
	# yea, this is very prone to breaking & is very hard to adjust
	var pick_power =  float(WorldManager.player.pick_lvl)
	var toughness = tilemap.get_cell_source_id(pos)
	if toughness >= 6 or toughness < 0: # unbreakable stuff
		return INF
	elif toughness == 0: # stone
		toughness = 1
	else:
		toughness -= 2
	
	return toughness / pick_power


func break_tile(pos: Vector2i):
	var source_id = tilemap.get_cell_source_id(pos)
	tilemap.erase_cell(pos)
	if source_id == TileType.STONE:
		return
	
	var c = 0
	for s in ["gold_ore", "iron_ore", "coal_ore"]:
		c += WorldManager.player.inv[s]

	if c >= 9: # max ore count
		return
	
	if source_id == TileType.GOLD:
		WorldManager.player.inv["gold_ore"] += 1
	elif source_id == TileType.IRON:
		WorldManager.player.inv["iron_ore"] += 1
	elif source_id == TileType.COAL:
		WorldManager.player.inv["coal_ore"] += 1


#region not really needed funcs
func to_tile_cords(pos):
	return tilemap.local_to_map(pos)

func to_map_cords(pos):
	return tilemap.map_to_local(pos)
#endregion

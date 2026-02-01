extends Node2D

@onready
var tilemap: TileMapLayer = $TileMapLayer
var id: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("enter_door"):
		# check if at entrance/exit
		var player = WorldManager.player
		var pos = to_tile_cords(Vector2i(0,0))
		var c = tilemap.get_cell_source_id(pos)
		if c == 1:
			WorldManager.enter_mine(player.area_num +1)
		elif c == 2:
			if player.area_num == 1:
				WorldManager.enter_town()
			WorldManager.enter_mine(player.area_num -1)
		

func get_data() -> PackedByteArray:
	return tilemap.tile_map_data
	
func set_data(tile_map_data: PackedByteArray): # TODO: default data
	tilemap.tile_map_data = tile_map_data

func set_default():
	#for i in range() # 22x13, start at -1, -1
	for i in range(22):
		for j in range(13):
			tilemap.set_cell(Vector2i(i - 1, j - 1), 0, Vector2i(0, 0))

#func get_break_time(player: Player, pos: Vector2i):
	## TODO: add picaxe level to player
	#if tilemap.get_cell_source_id(pos) != -1:
		#return 10
	#return -1 # nothing is there

func to_tile_cords(pos):
	return tilemap.local_to_map(pos)

func break_tile(pos: Vector2i):
	tilemap.erase_cell(pos)

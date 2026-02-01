extends Node2D

@onready
var tilemap: TileMapLayer = $TileMapLayer
var id: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("spacebar"):
		var up: Area2D = $up
		for thing in up.get_overlapping_bodies():
			if thing is Player:
				if thing.area_num == 1:
					WorldManager.enter_town(thing)
					return
				WorldManager.enter_mine(thing, 1)
				# FIXME: put num in enter_mine
				
		var down: Area2D = $down
		for thing in down.get_overlapping_bodies():
			if thing is Player:
				WorldManager.enter_mine(thing, 1)

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

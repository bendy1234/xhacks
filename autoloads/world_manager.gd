extends Node


const mine := preload("res://scenes/mine.tscn")
const map := preload("res://scenes/map.tscn")
const town := preload("res://scenes/town.tscn")
var current_lvl: Node

# dict of tilemap data, id
var mine_data = {}
var player: Player


enum Area {
	TOWN,
	MINE,
	MAP,
}

func save_mine_data(lvl: Node, id: int):
	# this just assumes that lvl is the mine sceen
	mine_data[id] = lvl.get_data()

func enter_mine(id: int, dir: int = 2): # 1 for up, 2 for down
	if current_lvl != null:
		if player.area == Area.MINE:
			save_mine_data(current_lvl, player.area_num)
		remove_child(current_lvl)

	player.area = Area.MINE
	player.area_num = id
	current_lvl = mine.instantiate();
	add_child(current_lvl)

	if mine_data.has(id):
		current_lvl.set_data(mine_data[id])
	else:
		current_lvl.set_default()
	var start_pos = current_lvl.find_tile(dir)
	player.position = current_lvl.to_map_cords(start_pos)

func enter_town():
	if player.area == Area.MINE:
		save_mine_data(current_lvl, player.area_num)
	if current_lvl != null:
		remove_child(current_lvl)

	player.area = Area.TOWN
	current_lvl = town.instantiate();
	add_child(current_lvl)
	# TODO: start pos


func enter_map():
	if player.area == Area.MINE:
		save_mine_data(current_lvl, player.area_num)

	if current_lvl != null:
		remove_child(current_lvl)

	player.area = Area.MAP
	current_lvl = map.instantiate();
	add_child(current_lvl)

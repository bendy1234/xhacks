extends Node


const mine := preload("res://scenes/mine.tscn")
const map := preload("res://scenes/map.tscn")
const town := preload("res://scenes/town.tscn")
var current_lvl: Node

#signal enter_mine(player, id)
#signal enter_town(player, id)

# dict of tilemap data, id -> idx
var mine_data = {}


enum Area {
	TOWN,
	MINE,
	MAP,
}

#func _ready() -> void: 
	#enter_mine.connect(enter_mine_)
	#enter_town.connect(enter_town_)

func save_mine_data(lvl: Node, id: int):
	# this just assumes that lvl is the mine sceen
	mine_data[id] = lvl.get_data()

func enter_mine(player: Player, id: int):
	if current_lvl != null:
		if player.area == Area.MINE:
			save_mine_data(current_lvl, player.area_num)
		remove_child(current_lvl)

	player.area = Area.MINE
	current_lvl = mine.instantiate();
	add_child(current_lvl)
	
	if mine_data.has(id):
		current_lvl.set_data(mine_data[id])
	else:
		current_lvl.set_default()
		
	
func enter_town(player: Player):
	if player.area == Area.MINE:
		save_mine_data(current_lvl, player.area_num)
	if current_lvl != null:
		remove_child(current_lvl)

	player.area = Area.TOWN
	current_lvl = town.instantiate();
	add_child(current_lvl)
	# TODO: start pos


func enter_map(player: Player):
	if player.area == Area.MINE:
		save_mine_data(current_lvl, player.area_num)
		
	if current_lvl != null:
		remove_child(current_lvl)

	player.area = Area.MAP
	current_lvl = map.instantiate();
	add_child(current_lvl)

extends Node


const mine := preload("res://scenes/mine.tscn")
const map := preload("res://scenes/map.tscn")
const town := preload("res://scenes/town.tscn")
var current_lvl: Node

#signal enter_mine(player, id)
#signal enter_town(player, id)

# list of tilemap data, id -> idx
var mine_data = []


enum Area {
	TOWN,
	MINE,
	MAP,
}

#func _ready() -> void: 
	#enter_mine.connect(enter_mine_)
	#enter_town.connect(enter_town_)

func enter_mine(player: Player):
	# TODO: check if player is in a mine already, if so, reuse the current level
	if current_lvl != null:
		remove_child(current_lvl)

	player.area = Area.MINE
	current_lvl = mine.instantiate();
	add_child(current_lvl)
	# TODO: load mine data
	
func enter_town(player: Player):
	if current_lvl != null:
		remove_child(current_lvl)

	player.area = Area.TOWN
	current_lvl = town.instantiate();
	add_child(current_lvl)
	# TODO: start pos


func enter_map(player: Player):
	if current_lvl != null:
		remove_child(current_lvl)

	player.area = Area.MAP
	current_lvl = map.instantiate();
	add_child(current_lvl)

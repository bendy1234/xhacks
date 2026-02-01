extends Node

#signal enter_mine(player, id)
#signal enter_town(player, id)

# list of tilemap data, id -> idx
var mines = []


enum Area {
	TOWN,
	MINE,
	MAP,
}

#func _ready() -> void: 
	#enter_mine.connect(enter_mine_)
	#enter_town.connect(enter_town_)

# TODO: switch sceens

func enter_mine(player: Player):
	player.area = Area.MINE
	
func enter_town(player: Player):
	player.area = Area.TOWN

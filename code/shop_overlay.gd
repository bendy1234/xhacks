extends Node2D

@export
var shop_type: ShopType = ShopType.Trade
var price = 0

func _ready() -> void:
	update_ui()

func update_ui():
	if shop_type == ShopType.Trade:
		$trade.visible = true
		var c = 0
		for s in ["gold_ore", "iron_ore", "coal_ore"]:
			c += ore_prices[s] * WorldManager.player.inv[s]
		price = c
		$trade/Button.text = "Sell Ores for %d$" % c
		if c == 0:
			$trade/Button.disabled = true
		
	elif shop_type == ShopType.Mine:
		$mine.visible = true
		if WorldManager.player.pick_lvl == Player.PickLvl.DIAMOND:
			$mine/Button.text = "Max level"
			$mine/Button.disabled = true
			return
		price = (WorldManager.player.pick_lvl + 1) * 100
		$mine/Button.text = "Upgrade Pickaxe: %d$" % price
			
		if price > WorldManager.player.coins:
			$mine/Button.disabled = true
	elif shop_type == ShopType.O2:
		price = 40
		if price > WorldManager.player.coins:
			$o2/Button.disabled = true
		$o2.visible = true

func sell_ore():
	for s in ["gold_ore", "iron_ore", "coal_ore"]:
		WorldManager.player.inv[s] = 0
	WorldManager.player.coins += price
	update_ui()

func buy_pick_upgrade():
	@warning_ignore("int_as_enum_without_cast")
	WorldManager.player.pick_lvl += 1
	
	WorldManager.player.coins -= price
	update_ui()
	
func buy_o2_tank():
	WorldManager.player.coins -= price
	update_ui()


enum ShopType {
	Trade,
	Mine,
	O2,
	Water, # ???
}


var ore_prices = {
	"coal_ore": 1,
	"iron_ore": 4,
	"gold_ore": 9
}

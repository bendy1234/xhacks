class_name Player
extends CharacterBody2D

#region position stuff
var area = WorldManager.Area.TOWN
var area_num = 0 # for mine depth & town number
#endregion

#region vars
var move_vel = 2 * 60
var allow_movement = true

var facing = Facing.RIGHT
var target_tile: Vector2i
var mining_time: float
var coins: int = 10

var pick_lvl: PickLvl = PickLvl.WOOD
var O2_lvl: int = 0
#endregion

#@export var inv: Inv
var inv := {
	"gold_ore": 0,
	"iron_ore": 0,
	"coal_ore": 0,
}

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var horz_dir = Input.get_axis("left", "right")
	var vert_dir = Input.get_axis("up", "down")
	if not allow_movement:
		horz_dir = 0
		vert_dir = 0

	velocity.x = horz_dir * move_vel
	velocity.y = vert_dir * move_vel
	
	if horz_dir > 0:
		facing = Facing.RIGHT
		$Sprite2D.texture = preload("res://assets/player_right.png")
	elif horz_dir < 0:
		$Sprite2D.texture = preload("res://assets/player_left.png")
		facing = Facing.LEFT
	elif vert_dir > 0:
		facing = Facing.DOWN
		$Sprite2D.texture = preload("res://assets/player_down.png")
	elif vert_dir < 0:
		facing = Facing.UP
		$Sprite2D.texture = preload("res://assets/player_up.png")
	
	if area == WorldManager.Area.MINE:
		if Input.is_action_pressed("mine"):
			var tile_pos = WorldManager.current_lvl.to_tile_cords(position) # holy this is crappy code
			# move forward by one
			if facing == Facing.RIGHT:
				tile_pos += Vector2i(1, 0)
			if facing == Facing.LEFT:
				tile_pos += Vector2i(-1, 0)
			if facing == Facing.UP:
				tile_pos += Vector2i(0, -1)
			if facing == Facing.DOWN:
				tile_pos += Vector2i(0, 1)
			progres_mining(tile_pos, delta)
			
	move_and_slide()

func progres_mining(tile: Vector2i, delta: float):
	var t = WorldManager.current_lvl.get_break_time(tile)
	if t == INF:
		WorldManager.current_lvl.block_breaking.visible = false
		return
	
	if target_tile != tile:
		target_tile = tile
		mining_time = 0
	mining_time += delta
	
	var progress = mining_time / t
	
	var frame = int(progress * 4)
	if frame < 4:
		WorldManager.current_lvl.block_breaking.visible = true
		WorldManager.current_lvl.block_breaking.position = WorldManager.current_lvl.to_map_cords(tile)
		WorldManager.current_lvl.block_breaking.frame = frame
	else:
		WorldManager.current_lvl.block_breaking.visible = false
	
	if progress >= 1:
		WorldManager.current_lvl.break_tile(tile)
	

enum Facing {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

enum PickLvl {
	WOOD = 1,
	STONE,
	IRON,
	DIAMOND,
}

#func collect(item):
	#inv.insert(item)

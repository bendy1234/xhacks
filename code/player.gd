class_name Player
extends CharacterBody2D

#region consts
const MOVE_VEL = 1.5 * 60
#endregion

#region position stuff
var area = WorldManager.Area.TOWN
var area_num = 0 # for mine depth & town number
#endregion

#region vars
var facing = Facing.RIGHT
#endregion

@export var inv: Inv
func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var horz_dir = Input.get_axis("left", "right")
	var vert_dir = Input.get_axis("up", "down")
	velocity.x = horz_dir * MOVE_VEL
	velocity.y = vert_dir * MOVE_VEL
	
	# TODO: change sprite
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
			# TODO: make this call the mining minigame
			WorldManager.current_lvl.break_tile(tile_pos)
			
	move_and_slide()

enum Facing {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

func collect(item):
	inv.insert(item)

class_name Player
extends CharacterBody2D

#region
const MOVE_VEL = 1.5 * 60
#endregion

#region position stuff
var area = WorldManager.Area.TOWN
var area_num = 0 # for mine depth & town number
var mine_states = [] # array to store tilemap data
#endregion

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var horz_dir = Input.get_axis("left", "right")
	var vert_dir = Input.get_axis("up", "down")
	velocity.x = horz_dir * MOVE_VEL
	velocity.y = vert_dir * MOVE_VEL
	
	# TODO: change sprite
	if horz_dir != 0:
		pass
	elif vert_dir != 0:
		pass
	
	if area == WorldManager.Area.MINE:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) || Input.is_action_pressed("spacebar"):
			pass
		
	move_and_slide()

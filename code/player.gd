extends CharacterBody2D

const MOVE_VEL = 1.5 * 60

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
		
	move_and_slide()

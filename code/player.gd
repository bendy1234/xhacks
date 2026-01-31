extends CharacterBody2D

# TODO: change speed
const MOVE_VEL = 10

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	var horz_dir = Input.get_axis("left", "right")
	var vert_dir = Input.get_axis("up", "down")
	velocity.x = move_toward(velocity.x, horz_dir * MOVE_VEL, 1)
	velocity.y = move_toward(velocity.y, vert_dir * MOVE_VEL, 1)

	move_and_slide()

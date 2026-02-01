extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if $Label.size.y < -$Label.position.y or Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if Input.is_action_pressed("spacebar"):
		$Label.position.y -= delta * 60
	$Label.position.y -= delta * 20
	

extends Node2D

func _ready() -> void:
	GameStuff.set_physics_process(false)

func _on_start_pressed() -> void:
	$Button_manager.visible = false
	$intro_msg.visible = true
	var t = $Timer
	t.timeout.connect(get_tree().change_scene_to_file.bind("res://scenes/main.tscn"))
	t.start(3)
	GameStuff.set_physics_process(true)
	GameStuff.time_till_rent += 3
	
	#get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

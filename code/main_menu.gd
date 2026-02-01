extends Node2D

func _on_start_pressed() -> void:
	$Button_manager.visible = false
	$intro_msg.visible = true
	var t = $Timer
	t.timeout.connect(get_tree().change_scene_to_file.bind("res://scenes/main.tscn"))
	t.start()
	#Signal
	
	#get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

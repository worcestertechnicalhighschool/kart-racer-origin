extends Control

func _on_resume_pressed() -> void:
	$".".queue_free()
	Engine.time_scale = 1

func _on_quit_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")

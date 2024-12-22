extends Control

func _on_resume_pressed() -> void:
	$".".hide()
	get_parent().get_node("Ui").show()
	Engine.time_scale = 1

func _on_quit_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")


func _on_respawn_pressed() -> void:
	pass

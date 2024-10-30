extends Control



func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/title_screen.tscn")

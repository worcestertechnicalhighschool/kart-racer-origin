extends Control



func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/curve_test.tscn")


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")

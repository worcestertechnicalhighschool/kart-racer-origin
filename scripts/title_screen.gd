extends Control



func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

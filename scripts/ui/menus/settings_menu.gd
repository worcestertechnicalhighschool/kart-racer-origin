extends Control


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)

func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")

extends Control

func _ready() -> void:
	var user_volume = AudioServer.get_bus_volume_db(1) # should be 0 by default
	
	if user_volume == -72: # this only happens when the slider should be on 0
		user_volume = -11 # add 11 to counteract the -11 to get 0
	
	$"./Music Volume".value = user_volume + 11 # add 11 as that is the start

func _on_music_volume_value_changed(value: float) -> void:
	if value == 0:
		AudioServer.set_bus_volume_db(1, -72)
	else:
		AudioServer.set_bus_volume_db(1, value - 11)

func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")

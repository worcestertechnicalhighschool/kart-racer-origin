extends Control

var button_pressed

func _ready() -> void:
	var master_volume = AudioServer.get_bus_volume_db(0) # should be 0 by default
	var music_volume = AudioServer.get_bus_volume_db(1) # should be 0 by default
	var sfx_volume = AudioServer.get_bus_volume_db(2) # should be 0 by default
	
	if master_volume == -72: # this only happens when the slider should be on 0
		master_volume = -12 # add 12 to counteract the -12 to get 0
	if music_volume == -72: 
		music_volume = -12
	if sfx_volume == -72: 
		sfx_volume = -12
	
	$MasterVolume.value = master_volume + 24 # add 24 as that is the start
	$MusicVolume.value = music_volume + 12 # add 12 as that is the start
	$SFXVolume.value = sfx_volume + 12 # add 12 as that is the start

	$UITransition._fade_in()

func _on_master_volume_value_changed(value: float) -> void:
	if value == 0:
		AudioServer.set_bus_volume_db(0, -72) 
	else:
		AudioServer.set_bus_volume_db(0, value - 24)

func _on_music_volume_value_changed(value: float) -> void:
	if value == 0:
		# if the slider is 0, mute, which can be done at -72 db
		AudioServer.set_bus_volume_db(1, -72) 
	else:
		# otherwise we simply set it to what the user picked
		AudioServer.set_bus_volume_db(1, value - 12) # -11 as the starting point is 11, which we want to be 0 db

func _on_sfx_volume_value_changed(value: float) -> void:
	if value == 0:
		AudioServer.set_bus_volume_db(2, -72) 
	else:
		AudioServer.set_bus_volume_db(2, value - 12)

func _on_go_back_pressed() -> void:
	button_pressed = "back"
	$UITransition._fade_out()

func _on_ui_transition_animation_end(is_fade_out: bool) -> void:
	if is_fade_out:
		
		match button_pressed:
			"back":
				get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")
	

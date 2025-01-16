extends Control

var button_pressed

func _ready() -> void:
	var user_volume = AudioServer.get_bus_volume_db(1) # should be 0 by default
	
	if user_volume == -72: # this only happens when the slider should be on 0
		user_volume = -11 # add 11 to counteract the -11 to get 0
	
	$MusicVolume.value = user_volume + 11 # add 11 as that is the start

	$UITransition._fade_in()

func _on_music_volume_value_changed(value: float) -> void:
	if value == 0:
		# if the slider is 0, mute, which can be done at -72 db
		AudioServer.set_bus_volume_db(1, -72) 
	else:
		# otherwise we simply set it to what the user picked
		AudioServer.set_bus_volume_db(1, value - 11) # -11 as the starting point is 11, which we want to be 0 db

func _on_go_back_pressed() -> void:
	button_pressed = "back"
	$UITransition._fade_out()

func _on_ui_transition_animation_end(is_fade_out: bool) -> void:
	if is_fade_out:
		
		match button_pressed:
			"back":
				get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")
	

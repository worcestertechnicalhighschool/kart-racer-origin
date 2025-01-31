extends Control

var button_pressed

func _ready() -> void:
	$UITransition._fade_in_title_screen()
	#MusicPlayer.play_music_level()

func _on_single_player_pressed() -> void:
	button_pressed = "main_menu"
	$SFX.play()
	$UITransition._fade_out()

func _on_settings_pressed() -> void:
	button_pressed = "settings_menu"
	$SFX.play()
	$UITransition._fade_out()

func _on_quit_pressed() -> void:
	$SFX.play()
	get_tree().quit()

func _on_ui_transition_animation_end(is_fade_out) -> void:
	if is_fade_out:
		
		get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/"+ button_pressed + ".tscn")
		

func get_active_device() -> String:
	var joypads = Input.get_connected_joypads()
	for id in joypads:
		var name = Input.get_joy_name(id).to_lower()
		if "wheel" in name or "logitech" in name or "g920" in name:
			return "wheel"
		elif "xbox" in name or "microsoft" in name:
			return "xbox"
	return "unknown"

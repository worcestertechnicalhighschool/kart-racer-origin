extends Control

var button_pressed

func _ready() -> void:
	$UITransition._fade_in()
	
	# goes to previous screen, with fade out
func _trigger_animation(button):
	button_pressed = button
	$AudioStreamPlayer.stop()
	$UITransition._fade_out()

func _on_go_back_pressed() -> void:
	_trigger_animation("main_menu")



func _on_ui_transition_animation_end(is_fade_out: bool) -> void:
	if is_fade_out:
		
		if button_pressed == "main_menu":
			get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/main_menu.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/map_scenes/" + button_pressed + ".tscn")

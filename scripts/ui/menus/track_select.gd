extends Control

var button_pressed

func _ready() -> void:
	$UITransition._fade_in()

# goes to previous screen, with fade out
func _trigger_animation(button):
	button_pressed = button
	$AudioStreamPlayer.stop()
	$UITransition._fade_out()

func _on_curve_test_button_pressed() -> void:
	_trigger_animation("curve_test_button")

func _on_trk_2_button_pressed() -> void:
	_trigger_animation("trk_2_button")

func _on_trk_3_button_pressed() -> void:
	_trigger_animation("trk_3_button")

func _on_donut_test_button_pressed() -> void:
	_trigger_animation("donut_button")

func _on_go_back_pressed() -> void:
	_trigger_animation("back")

func _on_ui_transition_animation_end(is_fade_out) -> void:
	if is_fade_out:

		if button_pressed == "back":
			get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/main_menu.tscn")
			
		elif button_pressed == "curve_test_button":
			get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")
		
		elif button_pressed == "trk_2_button":
			get_tree().change_scene_to_file("res://scenes/map_scenes/trk_2.tscn")
		
		elif button_pressed == "trk_3_button":
			get_tree().change_scene_to_file("res://scenes/map_scenes/trk_3.tscn")
		
		elif button_pressed == "donut_button":
			get_tree().change_scene_to_file("res://scenes/map_scenes/donut_test.tscn")

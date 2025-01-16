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

func _on_steamy_scrapyard_button_pressed() -> void:
	_trigger_animation("steamy_scrapyard")

func _on_sparkling_beach_button_pressed() -> void:
	_trigger_animation("sparkling_beach")

func _on_donut_test_button_pressed() -> void:
	_trigger_animation("donut_button")

func _on_go_back_pressed() -> void:
	_trigger_animation("back")

func _on_ui_transition_animation_end(is_fade_out: bool) -> void:
	if is_fade_out:

		match button_pressed:
			"back":
				get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/main_menu.tscn")
			"curve_test_button":
				get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")
			"steamy_scrapyard":
				get_tree().change_scene_to_file("res://scenes/map_scenes/steamy_scrapyard.tscn")
			"sparkling_beach":
				get_tree().change_scene_to_file("res://scenes/map_scenes/sparkling_beach.tscn")
			"donut_button":
				get_tree().change_scene_to_file("res://scenes/map_scenes/donut_test.tscn")

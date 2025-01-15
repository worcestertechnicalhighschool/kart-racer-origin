extends Control

func _on_texture_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")

func _on_trk_2_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/map_scenes/trk_2.tscn")

func _on_trk_3_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/map_scenes/trk_3.tscn")

func _on_donut_test_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/map_scenes/donut_test.tscn")

# goes to previous screen, with fade out
func _on_go_back_pressed() -> void:
	$UITransition._fade_out()
	
func _on_fade_in_animation_end() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/main_menu.tscn")

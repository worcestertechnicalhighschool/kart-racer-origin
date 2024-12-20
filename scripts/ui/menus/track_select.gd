extends Control

func _on_texture_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")


func _on_donut_test_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://assets/tracks/track_designs/donut_test.tscn")

# goes to previous screen, with fade out
func _on_go_back_pressed() -> void:
	$FadeIn.transition_toblack()
func _on_fade_in_animation_end() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/main_menu.tscn")

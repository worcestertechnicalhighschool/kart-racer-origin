extends Control

func _on_single_player_pressed() -> void:
	$SFX.play()
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/track_select.tscn")

func _on_go_back_pressed() -> void:
	$SFX.play()
	$UITransition._fade_out()
	
func _on_ui_transition_animation_end() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")

extends Control

#func _ready() -> void:
	#$FadeIn.transition_titlescreen()

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/track_select.tscn")

func _on_go_back_pressed() -> void:
	$FadeIn.transition_toblack()

func _on_fade_in_animation_end() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")

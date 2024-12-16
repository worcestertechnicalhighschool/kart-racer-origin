extends Control

func _ready() -> void:
	$FadeIn.transition_titlescreen()

func _on_single_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/main_menu.tscn")

extends Control

var button_pressed

func _ready() -> void:
	$UITransition._fade_in()

func _on_single_player_pressed() -> void:
	$SFX.play()
	button_pressed = "single_player"
	$UITransition._fade_out()

func _on_go_back_pressed() -> void:
	$SFX.play()
	button_pressed = "back"
	$UITransition._fade_out()
	
func _on_ui_transition_animation_end(is_fade_out: bool) -> void:
	if is_fade_out:
		
		match button_pressed:
			"back":
				get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/title_screen.tscn")
			"single_player":
				get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/track_select.tscn")

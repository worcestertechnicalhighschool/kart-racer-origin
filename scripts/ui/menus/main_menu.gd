extends Control

var button_pressed

func _ready() -> void:
	$UITransition._fade_in()
	
func _on_grand_prix_pressed() -> void:
	$SFX.play()
	button_pressed = "grand_prix_select"
	$UITransition._fade_out()
	
func _on_quick_race_pressed() -> void:
	$SFX.play()
	button_pressed = "track_select"
	$UITransition._fade_out()

func _on_go_back_pressed() -> void:
	$SFX.play()
	button_pressed = "title_screen"
	$UITransition._fade_out()
	
func _on_ui_transition_animation_end(is_fade_out: bool) -> void:
	if is_fade_out:
		
		get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/" + button_pressed + ".tscn")

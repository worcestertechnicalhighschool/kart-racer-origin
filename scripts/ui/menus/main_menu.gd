extends Control

@onready var preview_texture = $PreviewTexture

var all_textures = {}
var button_pressed

func _ready() -> void:
	$UITransition._fade_in()
	$PreviewTexture.visible = false
	all_textures[$VBoxContainer/GrandPrix] = preload("res://assets/images/menu_previews/grand_prix_preview.png")
	all_textures[$VBoxContainer/QuickRace] = preload("res://assets/images/menu_previews/vs_race_preview.png")
	all_textures[$VBoxContainer/TimeTrials] = preload("res://assets/images/menu_previews/time_trials_preview.png")
	
	for button in all_textures.keys():
		button.connect("focus_entered", Callable(self, "_on_button_focus").bind(button))
		button.connect("focus_exited", Callable(self, "_on_button_unfocus"))
		
func _on_button_focus(button: Button):
	if button in all_textures:
		preview_texture.texture = all_textures[button]
		preview_texture.visible = true
		
func _on_button_unfocus():
	preview_texture.visible = false
	
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

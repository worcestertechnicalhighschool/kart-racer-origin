extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# goes to curve_test.tscn
func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")

# goes to donut_test.tscn
func _on_donut_test_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/tracks/track_designs/donut_test.tscn")

# goes to previous screen
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/main_menu.tscn")

extends Control

func _ready() -> void:
	print(get_tree())

func _on_map_edit_text_submitted(new_text: String) -> void:
	get_tree().change_scene_to_file("res://scenes/map_scenes/" + new_text + ".tscn")

func _on_next_checkpoint_button_pressed() -> void:
	print("next checkpoint")

func _on_previous_checkpoint_button_pressed() -> void:
	print("prev checkpoint")

func _on_respawn_button_pressed() -> void:
	print("respawn")

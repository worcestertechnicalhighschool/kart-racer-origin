extends Control

func _ready() -> void:
	$".".visible = false

func _on_timer_timeout() -> void:
	# test cup, this is a band-aid solution that will change in the future
	if get_tree().get_current_scene().get_name() == "blender_track_1":
		get_tree().change_scene_to_file("res://scenes/map_scenes/blender_track_2.tscn")
	elif get_tree().get_current_scene().get_name() == "blender_track_2":
		get_tree().change_scene_to_file("res://scenes/map_scenes/blender_track_3.tscn")
	elif get_tree().get_current_scene().get_name() == "blender_track_3":
		get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")
	
	
	

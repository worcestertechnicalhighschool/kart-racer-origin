extends Control

func _on_timer_timeout() -> void:
	#get_tree().change_scene_to_file("res://scenes/map_scenes/steamy_scrapyard.tscn")
	
	# test cup, this is a bandaid solution that will change in the future
	if get_tree().get_current_scene().get_name() == "blender_track_1":
		get_tree().change_scene_to_file("res://scenes/map_scenes/blender_track_2.tscn")
	if get_tree().get_current_scene().get_name() == "blender_track_2":
		get_tree().change_scene_to_file("res://scenes/map_scenes/blender_track_3.tscn")
	if get_tree().get_current_scene().get_name() == "blender_track_3":
		get_tree().change_scene_to_file("res://scenes/map_scenes/curve_test.tscn")

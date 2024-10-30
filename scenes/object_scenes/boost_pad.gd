extends StaticBody3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if "car" in body.name.to_lower():
		var com
		
		for node in body.get_children():
			if node.name == "CenterOfMass":
				com = node
		
		if rotation_degrees.x > rotation_degrees.z:
			body.apply_central_force(Vector3(100 * sign(rotation_degrees.x), 0, 0)) 
		elif rotation_degrees.x < rotation_degrees.z:
			body.apply_central_force(Vector3(0, 0, 100 * sign(rotation_degrees.z))) 
		
		var fov_out_tween = get_tree().create_tween()
		fov_out_tween.tween_property(com.Cameras.FrontCamera, "fov", 115, 0.3)
		
		var center_of_mass_rotation_tween = get_tree().create_tween()
		center_of_mass_rotation_tween.tween_property(com, "rotation_degrees", Vector3(10, 0, 0), 0.3)
		
		$CameraTimer.start()

func _on_camera_timer_timeout() -> void:
	var fov_in_tween = get_tree().create_tween()
	#fov_in_tween.tween_property(camera, "fov", 75, 0.3)

	var center_of_mass_reversion_tween = get_tree().create_tween()
	#center_of_mass_reversion_tween.tween_property(com, "rotation_degrees", Vector3(0, 0, 0), 0.3)

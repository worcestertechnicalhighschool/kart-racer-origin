extends StaticBody3D

var front_camera_parent
var front_camera

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		
		front_camera_parent = body.find_child("Cameras")
		front_camera = front_camera_parent.find_child("FrontCamera")
		
		if body.rotation_degrees.x > body.rotation_degrees.z:
			body.apply_central_force(Vector3(100 * sign(rotation_degrees.x), 0, 0)) 
		elif body.rotation_degrees.x < body.rotation_degrees.z:
			body.apply_central_force(Vector3(0, 0, 100 * sign(rotation_degrees.z))) 
		
		var fov_out_tween = get_tree().create_tween()
		fov_out_tween.tween_property(front_camera, "fov", 115, 0.3)
		
		var center_of_mass_rotation_tween = get_tree().create_tween()
		center_of_mass_rotation_tween.tween_property(front_camera_parent, "rotation_degrees", Vector3(10, 0, 0), 0.3)
		
		$CameraTimer.start()

func _on_camera_timer_timeout() -> void:
	var fov_in_tween = get_tree().create_tween()
	fov_in_tween.tween_property(front_camera, "fov", 75, 0.3)

	var center_of_mass_reversion_tween = get_tree().create_tween()
	center_of_mass_reversion_tween.tween_property(front_camera_parent, "rotation_degrees", Vector3(0, 0, 0), 0.3)

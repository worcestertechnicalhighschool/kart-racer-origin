extends StaticBody3D

var car

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		
		car = body
		
		car.get_node("CameraComponent")._camera_out()
		
		$CameraTimer.start()

func _on_camera_timer_timeout() -> void:
	$CameraTimer.stop()

	car.get_node("CameraComponent")._camera_in()
	

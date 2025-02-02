extends StaticBody3D

var front_camera_parent
var front_camera
var car

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		
		car = body
		
		front_camera_parent = car.find_child("Cameras")
		front_camera = front_camera_parent.find_child("FrontCamera")
		
		car.get_node("CameraComponent")._camera_out()
		
		$CameraTimer.start()

func _on_camera_timer_timeout() -> void:

	car.get_node("CameraComponent")._camera_in()
	
	$CameraTimer.stop()

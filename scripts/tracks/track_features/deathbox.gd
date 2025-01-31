extends Area3D
var lakitu = Path3D.new()
var dead = false
var car_parts

func _on_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		car_parts = body.get_children()
		#dead = true
		#lakitu.curve = Curve3D.new()
		#lakitu.curve.add_point(body.position)
		#lakitu.curve.add_point(Vector3(body.position.x,body.RESPAWN[0].y+2,body.position.z))
		#lakitu.curve.add_point(body.RESPAWN[0] + Vector3(0,2,0))
		#lakitu.add_child(PathFollow3D.new())
		#for node in car_parts:
			#if node is MeshInstance3D:
				#lakitu.get_child(0).add_child(node)
			#if node is VehicleWheel3D:
				#lakitu.get_child(0).add_child(node.get_child(0))
			#if node.name == "Cameras":
				#node.reparent(lakitu.get_child(0))
		#get_parent().reparent(lakitu)
		body.position = body.RESPAWN[0] + Vector3(0,2,0)
		body.linear_velocity = Vector3(0,0,0)
		body.angular_velocity = Vector3(0,0,0)
		body.rotation = body.RESPAWN[1]
		#while(body.position.is_equal_approx(body.RESPAWN[0])):
			#body.position = Vector3(move_toward(body.position.x,body.RESPAWN[0].x,1),move_toward(body.position.y,body.RESPAWN[0].y+2,1),move_toward(body.position.z,body.RESPAWN[0].z,1))

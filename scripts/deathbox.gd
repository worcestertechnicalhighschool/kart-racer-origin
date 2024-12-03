extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		body.position = body.respawn[0] + Vector3(0,2,0)
		body.linear_velocity = Vector3(0,0,0)
		body.angular_velocity = Vector3(0,0,0)
		body.rotation = body.respawn[1]
		#while(body.position.is_equal_approx(body.respawn[0])):
			#body.position = Vector3(move_toward(body.position.x,body.respawn[0].x,1),move_toward(body.position.y,body.respawn[0].y+2,1),move_toward(body.position.z,body.respawn[0].z,1))

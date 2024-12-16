extends Area3D
var lakitu = Path3D.new()
var dead = false
var car_parts
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if dead:
		pass

func _on_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		car_parts = body.get_children()
		#dead = true
		#lakitu.curve = Curve3D.new()
		#lakitu.curve.add_point(body.position)
		#lakitu.curve.add_point(Vector3(body.position.x,body.respawn[0].y+2,body.position.z))
		#lakitu.curve.add_point(body.respawn[0] + Vector3(0,2,0))
		#lakitu.add_child(PathFollow3D.new())
		#for node in car_parts:
			#if node is MeshInstance3D:
				#lakitu.get_child(0).add_child(node)
			#if node is VehicleWheel3D:
				#lakitu.get_child(0).add_child(node.get_child(0))
			#if node.name == "Cameras":
				#node.reparent(lakitu.get_child(0))
		#get_parent().reparent(lakitu)
		body.position = body.respawn[0] + Vector3(0,2,0)
		body.linear_velocity = Vector3(0,0,0)
		body.angular_velocity = Vector3(0,0,0)
		body.rotation = body.respawn[1]
		#while(body.position.is_equal_approx(body.respawn[0])):
			#body.position = Vector3(move_toward(body.position.x,body.respawn[0].x,1),move_toward(body.position.y,body.respawn[0].y+2,1),move_toward(body.position.z,body.respawn[0].z,1))

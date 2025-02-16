extends Area3D
class_name TripComponent

@export var USES_COMPONENT : UsesComponent

var cars_collided = []

func _on_body_entered(body: Node3D) -> void:
	$"../AudioStreamPlayer3D".play()
	if body is VehicleBody3D and body not in cars_collided:
		cars_collided.append(body)
		body.linear_velocity.z = 0
		body.linear_velocity.x = 0
		body.linear_velocity.y += 10
		
		if USES_COMPONENT:
			USES_COMPONENT._change_uses(-1)

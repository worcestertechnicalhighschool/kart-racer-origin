extends RigidBody3D

var hit = false
var cars_collided = []
func _process(_delta: float) -> void:
	$CollisionShape3D.disabled = hit

func _on_area_3d_body_entered(body: Node3D) -> void:
	$AudioStreamPlayer3D.play()
	if body is VehicleBody3D and body not in cars_collided:
		cars_collided.append(body)
		hit = true
		body.linear_velocity.z = 0
		body.linear_velocity.x = 0
		body.linear_velocity.y += 10
		
		$"Properties/Uses".USES -= 1

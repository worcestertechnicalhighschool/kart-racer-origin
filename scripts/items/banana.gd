extends RigidBody3D

func _on_slip_body_entered(body: Node3D) -> void:
	if body != self:
		sleeping = true

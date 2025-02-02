extends "res://scripts/items/trip.gd"

func _on_slip_body_entered(body: Node3D) -> void:
	if body != self:
		freeze = true

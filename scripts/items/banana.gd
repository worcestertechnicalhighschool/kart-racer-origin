extends "res://scripts/items/trip.gd"

func _process(_delta: float) -> void:
	if $"Area3D".USES <= 0:
		queue_free()
		
	if linear_velocity.y == 0:
		freeze = true

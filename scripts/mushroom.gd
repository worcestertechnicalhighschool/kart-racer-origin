extends RigidBody3D

@export var CUSTOM_ANIMATION = true

func _process(_delta: float) -> void:
	var parent = $".."
	
	position = Vector3(parent.position.x, parent.position.y + 1, parent.position.z)

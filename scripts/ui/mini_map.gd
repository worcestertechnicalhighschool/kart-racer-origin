extends ColorRect

@export var player : VehicleBody3D
@export var camera_distance := 20.0

@onready var camera := $SubViewportContainer/SubViewport/Camera3D

func _process(delta: float) -> void:
	if player:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x, camera_distance, player.position.z)

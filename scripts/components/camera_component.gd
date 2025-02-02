extends Node3D

@export var CAMERA: Camera3D
@export var C_O_M: Node3D

@onready var car: VehicleBody3D = $".."

func _camera_out() -> void:
	car.SPEED_BOOST = true
	if car.ZOOM_DURATION == 0:
		var fov_out_tween = get_tree().create_tween()
		var center_of_mass_rotation_tween = get_tree().create_tween()
		fov_out_tween.tween_property(
			CAMERA, "fov", 115, 0.3
		)
		center_of_mass_rotation_tween.tween_property(
			C_O_M, "rotation_degrees", Vector3(10, 0, 0), 0.3
		)
	car.ZOOM_DURATION += 2.5

func _camera_in() -> void:
	car.ZOOM_DURATION -= 2.5
	if car.ZOOM_DURATION == 0:
		var fov_in_tween = get_tree().create_tween()
		var center_of_mass_reversion_tween = get_tree().create_tween()
		fov_in_tween.parallel().tween_property(
			CAMERA, "fov", 75, 0.3
		)
		center_of_mass_reversion_tween.parallel().tween_property(
			C_O_M, "rotation_degrees", Vector3(0, 0, 0), 0.3
		)
		car.SPEED_BOOST = false

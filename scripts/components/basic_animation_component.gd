extends Node3D
class_name BasicAnimationComponent

@export var THROWN_FORWARD = true

@onready var instance = get_parent()
@onready var thrown_objects = instance.get_parent()
@onready var car = thrown_objects.get_parent()

func _play() -> void:
	var car_lin_vel = car.linear_velocity
	
	instance.position = Vector3(thrown_objects.position.x, thrown_objects.position.y + 1, thrown_objects.position.z)
	instance.linear_velocity = Vector3(car_lin_vel.x * int(THROWN_FORWARD) * 2, 3, car_lin_vel.z * int(THROWN_FORWARD) * 2)

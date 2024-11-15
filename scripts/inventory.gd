extends Control

const BOMB = preload("res://scenes/object_scenes/bomb.tscn")
const SHELL = preload("res://scenes/object_scenes/shell.tscn")

func _process(_delta: float) -> void:
	var Car = $"../.."
	
	$"./Slot1/Label".text = Car.INVENTORY[0]
	$"./Slot2/Label".text = Car.INVENTORY[1]
	
	if Input.is_action_just_pressed("throw_item"):
		var instance
	
		if Car.INVENTORY[0] == "shell":
			instance = SHELL.instantiate()
		if Car.INVENTORY[0] == "bomb":
			instance = BOMB.instantiate()
	
		if instance:
			var car_lin_vel = Car.linear_velocity
			var throw_direction
			
			if instance.THROWN_FORWARD:
				throw_direction = 2
			else:
				throw_direction = -2
			
			instance.position = Vector3(Car.position.x, Car.position.y + 1, Car.position.z)
			instance.linear_velocity = Vector3(car_lin_vel.x * throw_direction, 3, car_lin_vel.z * throw_direction)
			Car.find_child("ThrownObjects").add_child(instance)
		
		Car.INVENTORY[0] = Car.INVENTORY[1]

		Car.INVENTORY[1] = ""

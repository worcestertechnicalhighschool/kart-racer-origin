extends Control

func _process(_delta: float) -> void:
	var car = $"../.."
	
	$"Slot2/Label".text = car.INVENTORY[1]
	$"Slot1/Label".text = car.INVENTORY[0]
	
	if Input.is_action_just_pressed("throw_item"):
		var instance
		
		if car.INVENTORY[0]:
			instance = load("res://scenes/object_scenes/obstacles/" + car.INVENTORY[0] + ".tscn").instantiate()
		
		if instance:
			var thrown_objects = car.find_child("ThrownObjects")
			
			if not instance.CUSTOM_ANIMATION:
				var car_lin_vel = car.linear_velocity
				var throw_direction
				
				if instance.THROWN_FORWARD:
					throw_direction = 2
				else:
					throw_direction = -2
				
				instance.position = Vector3(thrown_objects.position.x, thrown_objects.position.y + 1, thrown_objects.position.z)
				instance.linear_velocity = Vector3(car_lin_vel.x * throw_direction, 3, car_lin_vel.z * throw_direction)
			
			thrown_objects.add_child(instance)
		
		car.INVENTORY[0] = car.INVENTORY[1]
		car.INVENTORY[1] = ""

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
			
			thrown_objects.add_child(instance)
			
			instance.get_node("Properties").get_node("Animation")._play()
		
		car.INVENTORY[0] = car.INVENTORY[1]
		car.INVENTORY[1] = ""

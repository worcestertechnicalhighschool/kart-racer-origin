extends Control

const BOMB = preload("res://scenes/object_scenes/bomb.tscn")
const SHELL = preload("res://scenes/object_scenes/shell.tscn")

func _process(_delta: float) -> void:
	var Ui = $".."
	var Car = $"../.."
	
	$"./Slot1/Label".text = Car.inventory[0]
	$"./Slot2/Label".text = Car.inventory[1]
	
	if Input.is_action_just_pressed("throw_item"):
		var instance
	
		if Car.inventory[0] == "shell":
			instance = SHELL.instantiate()
		if Car.inventory[0] == "bomb":
			instance = BOMB.instantiate()
	
		if instance:
			instance.linear_velocity = Vector3(Car.linear_velocity.x, 3, Car.linear_velocity.z)
			instance.position = Vector3(Car.position.x, Car.position.y + 1, Car.position.z)
			Car.find_child("ThrownObjects").add_child(instance)
		
		Car.inventory[0] = Car.inventory[1]

		Car.inventory[1] = ""

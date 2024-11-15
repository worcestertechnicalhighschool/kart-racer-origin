extends Panel

func _process(_delta: float) -> void:
	var Ui = $".."
	var Car = $"../.."
	
	if Car.inventory:
		$"./Label".text = Car.inventory[0]

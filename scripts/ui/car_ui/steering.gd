extends Label

@onready var car = $"../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var steering = car.steering
	
	set_text(str(steering) + " " + str(car.engine_force))

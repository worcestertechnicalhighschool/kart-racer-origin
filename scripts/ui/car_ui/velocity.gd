extends Label

@onready var car = $"../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var linear_x = int(car.linear_velocity.x)
	var linear_y = int(car.linear_velocity.y)
	var linear_z = int(car.linear_velocity.z)
	
	set_text(str(linear_x) + " " + str(linear_y) + " " + str(linear_z))

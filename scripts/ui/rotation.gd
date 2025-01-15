extends Label

@onready var car = $"../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var rotation_x = int(car.rotation_degrees.x)
	var rotation_y = int(car.rotation_degrees.y)
	var rotation_z = int(car.rotation_degrees.z)
	
	set_text(str(rotation_x) + " " + str(rotation_y) + " " + str(rotation_z))

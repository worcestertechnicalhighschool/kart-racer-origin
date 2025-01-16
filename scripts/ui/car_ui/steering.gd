extends Label

@onready var car = $"../.."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var linear_x = int(Input.get_axis("right","left"))
	
	set_text(str(linear_x))

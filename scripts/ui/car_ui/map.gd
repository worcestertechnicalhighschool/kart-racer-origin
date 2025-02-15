extends Sprite2D

var curve_test_minimap = load("res://assets/images/minimaps/curve_test.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().get_current_scene().get_name() == "CurveTest":
		set_texture(curve_test_minimap)
	else:
		$".".visible = false
		print("MINIMAP TEXTURE NOT FOUND FOR TRACK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

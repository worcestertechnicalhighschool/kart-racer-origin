extends SubViewport

@onready var camera = $Camera2D

# gets the car node specifically
@onready var player = get_parent().get_parent().get_parent().get_parent()


func _physics_process(delta: float) -> void:
	camera.position = player.position

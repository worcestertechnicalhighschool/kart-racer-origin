extends Node3D

@export var USES = 1

func _process(_delta: float) -> void:
	if USES <= 0:
		$"..".queue_free()

extends Node3D
class_name UsesComponent

@export var USES = 1

func _process(_delta: float) -> void:
	if USES <= 0:
		$"..".queue_free()

func _change_uses(uses):
	USES += uses

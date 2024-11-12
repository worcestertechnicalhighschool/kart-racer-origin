extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	var inventory = body.find_child("Inventory")
	
	print(inventory.get_property_list())
	
	queue_free()

func _process(delta: float) -> void:
	print(position)

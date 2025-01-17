extends Area3D

@export var START_OR_FINISH_LINE: bool = false
@export var MAX_LAP: int = 3

var lap = 1
var cars_entered = []

func _ready() -> void:
	$Texture.queue_free()
	if START_OR_FINISH_LINE:
		get_parent().get_parent().get_node("GTR").get_node("Ui").get_node("Lap").text = "Lap 1/" + str(MAX_LAP)
	else:
		for checkpoints in get_parent().get_children():
			if checkpoints.START_OR_FINISH_LINE:
				set("MAX_LAP", checkpoints.MAX_LAP)

func _on_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		if body not in cars_entered:
			cars_entered.append(body)
			body.respawn = [position,rotation]
		if START_OR_FINISH_LINE:
			var i = 0
			for checkpoints in get_parent().get_children():
				i += int(body in checkpoints.cars_entered)
			if i == len(get_parent().get_children()):
				lap += 1
				for checkpoints in get_parent().get_children():
					checkpoints.cars_entered.erase(body)
				cars_entered.append(body)
			body.get_node("Ui").get_node("Lap").text = "Lap " + str(lap) + "/" + str(MAX_LAP)
			if lap + 1 > MAX_LAP:
				get_tree().change_scene_to_file("res://scenes/ui_scenes/transitions/track_transition.tscn")
		

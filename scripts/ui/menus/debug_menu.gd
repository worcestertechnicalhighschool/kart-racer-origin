extends Control

@onready var car = $".."
@onready var console = $Console

var maps = ["curve_test", "donut_test", "steamy_scrapyard", "sparkling_beach"]
var console_open = false

func _ready():
	console.visible = false

func _on_map_edit_text_submitted(new_text: String) -> void:
	if new_text in maps:
		get_tree().change_scene_to_file("res://scenes/map_scenes/" + new_text + ".tscn")
		Engine.time_scale = 1

func _on_next_checkpoint_button_pressed() -> void:
	print("next checkpoint")

func _on_previous_checkpoint_button_pressed() -> void:
	print("prev checkpoint")

func _on_respawn_button_pressed() -> void:
	car.position = car.RESPAWN[0] + Vector3(0,2,0)
	car.linear_velocity = Vector3(0,0,0)
	car.angular_velocity = Vector3(0,0,0)
	car.rotation = car.RESPAWN[1]

func _on_console_button_pressed() -> void:
	console_open = not console_open
	
	if console_open:
		console.show()
	else:
		console.hide()

extends Area3D

@export var USES_COMPONENT: UsesComponent

@onready var duration_timer = $DurationTimer

var car
var original = []
var original_rotation
var original_position
var car_parts

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if duration_timer.time_left > 0:
		for node in car_parts:
			if node is MeshInstance3D:
				if int(fmod(duration_timer.time_left*10,2)) == 1:
					node.transparency = 0
				if int(fmod(duration_timer.time_left*10,2)) == 0:
					node.transparency = 1
			if node is VehicleWheel3D:
				if int(fmod(duration_timer.time_left*10,2)) == 1:
					node.get_child(0).transparency = 0
				if int(fmod(duration_timer.time_left*10,2)) == 0:
					node.get_child(0).transparency = 1


func _on_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D and duration_timer.is_stopped():
		car = body
		car_parts = body.get_children()
		for node in car_parts:
			if node is VehicleWheel3D:
				original.append(node.wheel_friction_slip)
				node.wheel_friction_slip = 0
			if node.name == "Cameras":
				original_rotation = node.rotation_degrees
				original_position = node.position
				node.top_level = true
				
		
		body.linear_velocity.x = body.linear_velocity.x/5
		body.linear_velocity.z = body.linear_velocity.z/5
		body.angular_velocity.y = 10
		
		$"../MeshInstance3D".queue_free()
		
		duration_timer.start()

func _on_duration_timer_timeout() -> void:
	duration_timer.stop()
	var i = 0
	for node in car_parts:
		if node is VehicleWheel3D:
			node.wheel_friction_slip = original[i]
		if node.name == "Cameras":
			node.top_level = false
			node.rotation_degrees = original_rotation
			node.position = original_position
		if node is MeshInstance3D:
			node.transparency = 0
		if node is VehicleWheel3D:
			node.get_child(0).transparency = 0
			
			
	USES_COMPONENT._change_uses(-1)

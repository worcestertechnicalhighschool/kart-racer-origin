extends Node3D

@export var ONE_USE = true

@onready var original_position = position
var list_of_throwables = ["shell"] # "mushroom","banana" , "bomb", 
var rng = RandomNumberGenerator.new()
var tween_playing = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		
		var random_number = rng.randi_range(0, len(list_of_throwables) - 1)
		
		if body.INVENTORY[0]:
			if not body.INVENTORY[1]:
				body.INVENTORY[1] = list_of_throwables[random_number]
		else:
			body.INVENTORY[0] = list_of_throwables[random_number]
		
		if ONE_USE:
			queue_free()

func _process(_delta: float) -> void:
	if not tween_playing:
		_start_tween()

func _start_tween():
	tween_playing = true
	
	var position_tween_up = create_tween()
	position_tween_up.set_trans(Tween.TRANS_QUAD)
	position_tween_up.set_ease(Tween.EASE_IN)
	position_tween_up.parallel().tween_property(
		self,
		"position",
		Vector3(position.x, original_position.y + 0.5, position.z),
		1.5
	)
	
	position_tween_up.tween_callback(_play_down_tween)
	
func _play_down_tween():
	await get_tree().create_timer(0.3).timeout
	
	var position_tween_down = create_tween()
	position_tween_down.set_trans(Tween.TRANS_QUAD)
	position_tween_down.set_ease(Tween.EASE_OUT)
	position_tween_down.parallel().tween_property(
		self,
		"position",
		Vector3(position.x, original_position.y, position.z),
		1.5
	)
	
	position_tween_down.tween_callback(_set_false)
	
func _set_false():
	tween_playing = false

extends RigidBody3D

@export var CUSTOM_ANIMATION = true
@onready var ThrownObjects = $".."
@onready var Car = $"../.."
@onready var Forcefield = Car.find_child("Forcefield")
var tween_playing = false
var front_camera_parent
var front_camera

func _process(_delta: float) -> void:
	position = Vector3(ThrownObjects.position.x, ThrownObjects.position.y + 1, ThrownObjects.position.z)
	Forcefield.visible = true
	
	if not tween_playing:
		tween_playing = true
		_apply_effects()
		$AnimationTimer.start()

func _apply_effects():
	front_camera_parent = Car.find_child("Cameras")
	front_camera = front_camera_parent.find_child("FrontCamera")
	
	if Car.rotation_degrees.x >= Car.rotation_degrees.z:
		Car.apply_central_force(Vector3(100 * sign(rotation_degrees.x), 0, 0)) 
	elif Car.rotation_degrees.x < Car.rotation_degrees.z:
		Car.apply_central_force(Vector3(0, 0, 100 * sign(rotation_degrees.z))) 
	
	var fov_out_tween = get_tree().create_tween()
	fov_out_tween.tween_property(front_camera, "fov", 115, 0.3)
	
	var center_of_mass_rotation_tween = get_tree().create_tween()
	center_of_mass_rotation_tween.tween_property(front_camera_parent, "rotation_degrees", Vector3(10, 0, 0), 0.3)
	
	$CameraTimer.start()

func _visibility():
	visible = not Forcefield.visible

func _on_camera_timer_timeout() -> void:
	var fov_in_tween = get_tree().create_tween()
	fov_in_tween.tween_property(front_camera, "fov", 75, 0.3)

	var center_of_mass_reversion_tween = get_tree().create_tween()
	center_of_mass_reversion_tween.tween_property(front_camera_parent, "rotation_degrees", Vector3(0, 0, 0), 0.3)
	
	var forcefield_visibility_tween = get_tree().create_tween()
	forcefield_visibility_tween.tween_property(Forcefield, "albedo_color", Color(0, 0, 0, 0), 0.3)
	
	forcefield_visibility_tween.tween_callback(_visibility)
	center_of_mass_reversion_tween.tween_callback(queue_free)

func _on_animation_timer_timeout() -> void:
	var position_tween_down = create_tween()
	position_tween_down.set_trans(Tween.TRANS_QUAD)
	position_tween_down.set_ease(Tween.EASE_IN)
	position_tween_down.parallel().tween_property(
		self,
		"position",
		Vector3(ThrownObjects.position.x, ThrownObjects.position.y, ThrownObjects.position.z),
		0.1
	)
	
	position_tween_down.tween_callback(_visibility)

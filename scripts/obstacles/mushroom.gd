extends RigidBody3D

@export var CUSTOM_ANIMATION = true
@onready var ThrownObjects = $".."
@onready var Car = $"../.."
@onready var Forcefield = $"../../Forcefield"
@onready var original_color = Forcefield.mesh.material.albedo_color

var tween_playing = false
var front_camera_parent
var front_camera

func _visibility():
	visible = not Forcefield.visible
	
func _reset():
	Forcefield.visible = false
	Forcefield.mesh.material.albedo_color = original_color
	
	$Placeholder.start()

func _ready() -> void:
	Forcefield.visible = true
	Forcefield.mesh.material.albedo_color = Color(0, 0, 0, 0)
	
	var position_tween_up = create_tween()
	position_tween_up.set_trans(Tween.TRANS_QUAD)
	position_tween_up.set_ease(Tween.EASE_IN)
	position_tween_up.parallel().tween_property(
		self,
		"position",
		Vector3(ThrownObjects.position.x, ThrownObjects.position.y + 1.25, ThrownObjects.position.z),
		0.1
	)
	
	var forcefield_visibility_tween = get_tree().create_tween()
	forcefield_visibility_tween.tween_property(
		Forcefield.mesh.material,
		"albedo_color",
		original_color,
		0.1
	)

func _integrate_forces(_state: PhysicsDirectBodyState3D):
	position = Vector3(ThrownObjects.position.x, ThrownObjects.position.y + 1.25, ThrownObjects.position.z)
	
	if not tween_playing:
		tween_playing = true
		_apply_effects()
		$AnimationTimer.start()

func _apply_effects():
	front_camera_parent = Car.find_child("Cameras")
	front_camera = front_camera_parent.find_child("FrontCamera")
	
	if Car.rotation_degrees.x >= Car.rotation_degrees.z:
		Car.linear_velocity += (Vector3(10 * sign(rotation_degrees.x), 0, 0)) 
	elif Car.rotation_degrees.x < Car.rotation_degrees.z:
		Car.linear_velocity += (Vector3(0, 0, 10 * sign(rotation_degrees.x))) 
	
	var fov_out_tween = get_tree().create_tween()
	fov_out_tween.tween_property(front_camera, "fov", 115, 0.3)
	
	var center_of_mass_rotation_tween = get_tree().create_tween()
	center_of_mass_rotation_tween.tween_property(front_camera_parent, "rotation_degrees", Vector3(10, 0, 0), 0.3)
	
	$CameraTimer.start()

func _on_camera_timer_timeout() -> void:
	var fov_in_tween = get_tree().create_tween()
	fov_in_tween.parallel().tween_property(front_camera, "fov", 75, 0.3)

	var center_of_mass_reversion_tween = get_tree().create_tween()
	center_of_mass_reversion_tween.parallel().tween_property(front_camera_parent, "rotation_degrees", Vector3(0, 0, 0), 0.3)
	
	var forcefield_visibility_tween = get_tree().create_tween()
	forcefield_visibility_tween.parallel().tween_property(Forcefield.mesh.material, "albedo_color", Color(0, 0, 0, 0), 0.3)

	forcefield_visibility_tween.tween_callback(_reset)

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

func _on_placeholder_timeout() -> void:
	queue_free()

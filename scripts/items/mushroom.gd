extends RigidBody3D

#@export var CUSTOM_ANIMATION = true
#@onready var thrown_objects = $".."
#@onready var car = $"../.."
#@onready var forcefield = $"../../Forcefield"
#@onready var original_color = forcefield.mesh.material.albedo_color
#
#var tween_playing = false
#var front_camera_parent
#var front_camera

#func _ready() -> void:
	#forcefield.mesh.material.albedo_color = Color(0, 0, 0, 0)
	#forcefield.visible = true
	#
	#var forcefield_visibility_tween = get_tree().create_tween()
	#forcefield_visibility_tween.tween_property(
		#forcefield.mesh.material, "albedo_color", original_color, 0.1
	#)
	#var position_tween_up = create_tween()
	#position_tween_up.set_trans(Tween.TRANS_QUAD)
	#position_tween_up.set_ease(Tween.EASE_IN)
	#position_tween_up.parallel().tween_property(
		#self, "position", Vector3(thrown_objects.position.x, thrown_objects.position.y + 1.25, thrown_objects.position.z), 0.1
	#)
#
#func _integrate_forces(_state) -> void:
	#position = Vector3(thrown_objects.position.x, thrown_objects.position.y + 1.25, thrown_objects.position.z)
	#
	#if not tween_playing:
		#tween_playing = true
		#car.SPEED_BOOST = true
		#
		#front_camera_parent = car.find_child("Cameras")
		#front_camera = front_camera_parent.find_child("FrontCamera")
		#
		#if car.ZOOM_DURATION == 0:
			#var fov_out_tween = get_tree().create_tween()
			#var center_of_mass_rotation_tween = get_tree().create_tween()
			#fov_out_tween.tween_property(
				#front_camera, "fov", 115, 0.3
			#)
			#center_of_mass_rotation_tween.tween_property(
				#front_camera_parent, "rotation_degrees", Vector3(10, 0, 0), 0.3
			#)
		#
		#car.ZOOM_DURATION += 2.5
		#
		#$AnimationTimer.start()
		#$CameraTimer.start()
#
#func _visibility():
	#visible = false
	#
#func _reset():
	#forcefield.mesh.material.albedo_color = original_color
	#forcefield.visible = false
	#
	#car.SPEED_BOOST = false
#
#func _on_animation_timer_timeout() -> void:
	#var position_tween_down = create_tween()
	#position_tween_down.set_trans(Tween.TRANS_QUAD)
	#position_tween_down.set_ease(Tween.EASE_IN)
	#position_tween_down.parallel().tween_property(
		#self, "position", Vector3(thrown_objects.position.x, thrown_objects.position.y, thrown_objects.position.z), 0.1
	#)
	#
	#position_tween_down.tween_callback(_visibility)
#
#func _on_camera_timer_timeout() -> void:
	#car.ZOOM_DURATION -= 2.5
	#if car.ZOOM_DURATION == 0:
		#var fov_in_tween = get_tree().create_tween()
		#var center_of_mass_reversion_tween = get_tree().create_tween()
		#fov_in_tween.parallel().tween_property(
			#front_camera, "fov", 75, 0.3
		#)
		#center_of_mass_reversion_tween.parallel().tween_property(
			#front_camera_parent, "rotation_degrees", Vector3(0, 0, 0), 0.3
		#)
	#
	#var forcefield_visibility_tween = get_tree().create_tween()
	#forcefield_visibility_tween.parallel().tween_property(
		#forcefield.mesh.material, "albedo_color", Color(0, 0, 0, 0), 0.3
	#)
#
	#forcefield_visibility_tween.tween_callback(_reset)
	#
	#$DestroyTimer.start()
#
#func _on_destroy_timer_timeout() -> void:
	#queue_free()

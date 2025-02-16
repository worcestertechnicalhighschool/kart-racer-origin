extends RigidBody3D

@export var FUSE = 2
@export var LINGER = 1

var exploded = false
func _ready() -> void:
	$TripComponent/CollisionShape3D.disabled = true
	$Timer.start(FUSE)

func _on_timer_timeout() -> void:
	if not exploded:
		$BombMesh.visible = false
		$CollisionShape3D.disabled = true
		$Explosion.visible = true
		$TripComponent/CollisionShape3D.disabled = false
		exploded = true
		$AudioStreamPlayer3D.play()
		$Timer.start(LINGER)
		axis_lock_linear_y = true
		axis_lock_linear_x = true
		axis_lock_linear_z = true
	else:
		queue_free()

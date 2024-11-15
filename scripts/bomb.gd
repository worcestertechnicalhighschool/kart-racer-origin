extends "res://scripts/trip.gd"
@export var FUSE = 2
@export var LINGER = 1

var exploded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(FUSE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if !exploded:
		$BombMesh.visible = false
		$CollisionShape3D.disabled = true
		$Explosion.visible = true
		$Area3D/CollisionShape3D.disabled = false
		exploded = true 
		$Timer.start(LINGER)
		axis_lock_linear_y = true
		axis_lock_linear_x = true
		axis_lock_linear_z = true
	else:
		queue_free()

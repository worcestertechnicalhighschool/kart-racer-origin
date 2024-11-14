extends "res://scripts/trip.gd"
@export var FUSE = 2
@export var LINGER = 1
var exploded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(FUSE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if !exploded:
		$BombMesh.visible = false
		$CollisionShape3D.disabled = false
		$Explosion.visible = true
		exploded = true
		$Timer.start(LINGER)
	else:
		queue_free()

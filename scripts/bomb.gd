extends "res://scripts/trip.gd"
@export var TTB = 5
@export var BLAST_LENGTH = 5
var exploded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(TTB)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if !exploded:
		$BombMesh.visible = false
		$CollisionShape3D.disabled = false
		$Explosion.visible = true
		$Timer.start(BLAST_LENGTH)
		exploded = true
	else:
		queue_free()

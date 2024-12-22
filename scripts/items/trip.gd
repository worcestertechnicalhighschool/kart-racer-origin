extends RigidBody3D
@export var ONE_USE = true
@export var THROWN_FORWARD = true
@export var CUSTOM_ANIMATION = false

var hit = false
var cars_collided = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$CollisionShape3D.disabled = hit

func _on_area_3d_body_entered(body: Node3D) -> void:
	$AudioStreamPlayer3D.play()
	if body is VehicleBody3D and body not in cars_collided:
		cars_collided.append(body)
		hit = true
		body.linear_velocity.z = 0
		body.linear_velocity.x = 0
		body.linear_velocity.y += 10
		if ONE_USE:
			queue_free()
		else:
			pass

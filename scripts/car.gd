#Old Car Code
#
#var max_rpm = 500
#var max_torque = 200
#
#func _physics_process(delta: float) -> void:
	#if Input.get_axis("backward", "forward"):
		#$BackLeftWheel.wheel_friction_slip = 10
		#$BackRightWheel.wheel_friction_slip = 10
	#else:
		#$BackLeftWheel.wheel_friction_slip = 3
		#$BackRightWheel.wheel_friction_slip = 3
	#
	#steering = lerp(steering, Input.get_axis("right", "left") * 0.4, 5 * delta)
	#var acceleration = Input.get_axis("backward", "forward")
	#var rpm = $BackLeftWheel.get_rpm()
	#$BackLeftWheel.engine_force = acceleration * max_torque * (1 - rpm / max_rpm) * 2
	#rpm = $BackRightWheel.get_rpm()
	#$BackRightWheel.engine_force = acceleration * max_torque * (1 - rpm / max_rpm) * 2


extends VehicleBody3D

@onready var blwheel = $BackLeftWheel
@onready var brwheel = $BackRightWheel
@onready var flwheel = $FrontLeftWheel
@onready var frwheel = $FrontRightWheel
@onready var camera = $Cameras/FrontCamera
@onready var ui = $Ui
@onready var pausemenu = $PauseMenu

@export var INVENTORY = ["", ""]
@export var MAX_STEER = 0.9
@export var ENGINE_POWER = 500
@export var DRIFT = 1

var drift
var old_rotation
var old_position
var old_velocity
var axis
var respawn
var paused = false
	
func _ready() -> void:
	ui.visible = true
	pausemenu.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	print(linear_velocity)
	
	#apply_impulse(Vector3(0,0,10),Vector3(0,0,0))
	#print(global_rotation_degrees)
	#apply_central_impulse(Vector3(0,0,10))
	
	#print(linear_velocity)
	#print(rotation_degrees,rotation)
	#print(linear_velocity)
	if Input.is_action_pressed("drift") and Input.get_axis("right","left") != 0 and !drift:
		#Takes the all the cars positional and rotational data at the time of the drift along with the way that the car is turning
		drift = true
		axis = Input.get_axis("right","left")
		steering = Input.get_axis("right","left")
		old_rotation = global_rotation_degrees
		old_position = position
		old_velocity = linear_velocity
	if Input.is_action_just_released("drift"):
		blwheel.wheel_friction_slip = 10.5
		brwheel.wheel_friction_slip = 10.5
		flwheel.wheel_friction_slip = 10.5
		frwheel.wheel_friction_slip = 10.5
		drift = false
		angular_velocity.y = 0
		global_rotation_degrees.y = 0
	
		linear_velocity.z = old_velocity.z
		
	if !drift:
		engine_force = Input.get_axis("backward","forward") * ENGINE_POWER
		steering = move_toward(steering, Input.get_axis("right","left") * MAX_STEER, delta * 10)
	if drift:
		engine_force = ENGINE_POWER
		steering = move_toward(steering, axis * MAX_STEER, delta * 10)
	
	# listens for pause button
	
	if Input.is_action_just_pressed("pause"):
		open_pause()

func _integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
	pass
	

func open_pause():
	# unpauses if already paused
	if paused:
		pausemenu.hide()
		Engine.time_scale = 1
	# pauses if not paused
	else:
		pausemenu.show()
		Engine.time_scale = 0
	
	paused = not paused

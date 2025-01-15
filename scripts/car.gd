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
@export var ZOOM_DURATION = 0
@export var respawn = []

var drift
var old_rotation
var old_position
var old_velocity
var axis
var paused = false
var prior
	
func _ready() -> void:
	respawn = [position, global_rotation_degrees]
	ui.visible = true
	pausemenu.visible = false

func _physics_process(delta: float) -> void:
	#var current = Vector2(linear_velocity.x, linear_velocity.z)
	
	#print(current)
	
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

func open_pause():
	# unpauses if already paused
	if paused:
		pausemenu.hide()
		ui.show()
		Engine.time_scale = 1
		
	# pauses if not paused
	else:
		pausemenu.show()
		ui.hide()
		Engine.time_scale = 0
	
	paused = not paused

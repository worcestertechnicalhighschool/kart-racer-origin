extends VehicleBody3D

@onready var bl_wheel = $BackLeftWheel
@onready var br_wheel = $BackRightWheel
@onready var fl_wheel = $FrontLeftWheel
@onready var fr_wheel = $FrontRightWheel
@onready var camera = $Cameras/FrontCamera
@onready var ui = $Ui
@onready var pause_menu = $PauseMenu
@onready var debug_menu = $DebugMenu

@export var INVENTORY = ["", ""]
@export var MAX_STEER = 0.9
@export var ENGINE_POWER = 500
@export var DRIFT = 1
@export var ZOOM_DURATION = 0
@export var RESPAWN = []
@export var SPEED_BOOST = false

var drift
var old_rotation
var old_position
var old_velocity
var axis
var paused = false
var debug_open = false
var prior
	
func _ready() -> void:
	RESPAWN = [position, global_rotation_degrees]
	ui.visible = true
	pause_menu.visible = false
	debug_menu.visible = false

func _physics_process(delta: float) -> void:

	#print(ZOOM_DURATION)
	
	#var current = Vector2(linear_velocity.x, linear_velocity.z)
	
	#print(InputEventJoypadMotion.new().axis_value)
	
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
		bl_wheel.wheel_friction_slip = 10.5
		br_wheel.wheel_friction_slip = 10.5
		fl_wheel.wheel_friction_slip = 10.5
		fr_wheel.wheel_friction_slip = 10.5
		drift = false
		angular_velocity.y = 0
		global_rotation_degrees.y = 0
	
		linear_velocity.z = old_velocity.z
		
	if !drift:
		#bl_wheel.wheel_friction_slip = 20
		#fl_wheel.wheel_friction_slip = 20
		#br_wheel.wheel_friction_slip = 20
		#fr_wheel.wheel_friction_slip = 20
		#bl_wheel.wheel_roll_influence = 1
		#fl_wheel.wheel_roll_influence = 1
		#br_wheel.wheel_roll_influence = 1
		#fr_wheel.wheel_roll_influence = 1
		
		rotation_degrees.x = clamp(rotation_degrees.x, -10, 10)
		rotation_degrees.z = clamp(rotation_degrees.z, -10, 10)
		
		if SPEED_BOOST:
			ENGINE_POWER *= 2
		
		#print(Input.get_action_strength("backward"))
		
		if Input.get_action_strength("backward") < 1:
			engine_force = (Input.get_action_strength("backward")) * -1 * ENGINE_POWER
		else:
			engine_force = Input.get_action_strength("forward") * ENGINE_POWER
		
		steering = Input.get_axis("right","left") * MAX_STEER
		
		ENGINE_POWER = 500
		
		#if 
			#engine_force += 500 * engine_force / ENGINE_POWER
		
	if drift:
		engine_force = ENGINE_POWER
		steering = move_toward(steering, axis * MAX_STEER, delta * 10)
	
	# listens for pause button
	
	if Input.is_action_just_pressed("pause"):
		open_pause()
	elif Input.is_action_just_pressed("debug"):
		open_debug()
	

func open_pause():
	# unpauses if already paused
	if paused:
		pause_menu.hide()
		ui.show()
		Engine.time_scale = 1
		
	# pauses if not paused
	else:
		pause_menu.show()
		pause_menu.find_child("Resume").grab_focus()
		
		ui.hide()
		Engine.time_scale = 0
	
	paused = not paused
	
func open_debug():
	debug_open = not debug_open
	
	if debug_open:
		debug_menu.show()
		debug_menu.find_child("MapEdit").grab_focus()
		Engine.time_scale = 0
		
	else:
		debug_menu.hide()
		Engine.time_scale = 1
	

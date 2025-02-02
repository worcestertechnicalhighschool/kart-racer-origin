extends VehicleBody3D

@onready var bl_wheel = $BackLeftWheel
@onready var br_wheel = $BackRightWheel
@onready var fl_wheel = $FrontLeftWheel
@onready var fr_wheel = $FrontRightWheel
@onready var camera = $Cameras/FrontCamera
@onready var ui = $Ui
@onready var pause_menu = $PauseMenu
@onready var debug_menu = $DebugMenu
@onready var transition_screen = $TrackTransition

@export var INVENTORY = ["", ""]
@export var MAX_STEER = 0.9
@export var ENGINE_POWER = 500
@export var DRIFT = 1
@export var ZOOM_DURATION = 0
@export var RESPAWN = []
@export var SPEED_BOOST = false

var MAX_SPEED = 45
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
	#transition_screen.visibile = false

func _integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
	
	ENGINE_POWER = 500
	MAX_SPEED = 50

	#if Input.is_action_pressed("drift") and Input.get_axis("right","left") != 0 and !drift:
		##Takes the all the cars positional and rotational data at the time of the drift along with the way that the car is turning
		#drift = true
		#axis = Input.get_axis("right","left")
		#steering = Input.get_axis("right","left")
		#old_rotation = global_rotation_degrees
		#old_position = position
		#old_velocity = linear_velocity
	#if Input.is_action_just_released("drift"):
		#bl_wheel.wheel_friction_slip = 10.5
		#br_wheel.wheel_friction_slip = 10.5
		#fl_wheel.wheel_friction_slip = 10.5
		#fr_wheel.wheel_friction_slip = 10.5
		#drift = false
		#angular_velocity.y = 0
		#global_rotation_degrees.y = 0
	#
		#linear_velocity.z = old_velocity.z
		
	if !drift:
		
		if SPEED_BOOST:
			ENGINE_POWER *= 2
			MAX_SPEED *= 1.5
		
		# checking for a negative value bacause holding accel. pedal gives a negative number.
		if Input.get_action_strength("pedal_reverse") < 1 and Input.get_action_strength("pedal_reverse"):
			engine_force = Input.get_action_strength("pedal_reverse") * -1 * ENGINE_POWER
		elif Input.get_action_strength("pedal_accelerate"):
			engine_force = Input.get_action_strength("pedal_accelerate") * ENGINE_POWER
		else:
			engine_force = Input.get_axis("non_pedal_reverse", "non_pedal_accelerate") * ENGINE_POWER
		
		steering = Input.get_axis("steer_right","steer_left") * MAX_STEER / 4
		
		# clamp rotation degrees so car doesn't radically flip over
		rotation_degrees.x = clamp(rotation_degrees.x, -10, 10)
		rotation_degrees.z = clamp(rotation_degrees.z, -10, 10)
		
		# overall purpose: limiting the total speed
		# finding the magnitude of the vector
		var speed = sqrt(linear_velocity.x**2 + linear_velocity.z**2)
		# only limit if speed is greater than speed
		if speed > MAX_SPEED:
			# get the inverse of the ratio to scale down vector magnitudes
			var ratio = MAX_SPEED / speed
			linear_velocity.x *= ratio
			linear_velocity.z *= ratio

	#if drift:
		#engine_force = ENGINE_POWER
		#steering = move_toward(steering, axis * MAX_STEER, delta * 10)
	
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
	

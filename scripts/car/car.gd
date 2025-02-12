extends VehicleBody3D

@export_group("Nodes")
@export var BL_WHEEL: VehicleWheel3D
@export var BR_WHEEL: VehicleWheel3D
@export var FL_WHEEL: VehicleWheel3D
@export var FR_WHEEL: VehicleWheel3D
@export var CAMERA: Camera3D

@export_group("Customs")
@export var INVENTORY = ["", ""]
@export var MAX_STEER = 0.9
@export var ENGINE_POWER = 500
@export var DRIFT = 1
@export var ZOOM_DURATION = 0
@export var RESPAWN = []
@export var SPEED_BOOST = false

@onready var ui = $"Ui"
@onready var pause_menu = $"PauseMenu"
@onready var debug_menu = $"DebugMenu"

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
	
	var original_angle = rotation_degrees.y
	
	ENGINE_POWER = 500
	MAX_SPEED = 50
	
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

	if drift:
		position.dot(linear_velocity) / sqrt(position.x**2 + position.y**2 + position.z**2) * sqrt(linear_velocity.x**2 + linear_velocity.y**2 + linear_velocity.z**2)
		

	if Input.is_action_just_pressed("pause"):
		open_pause()
	elif Input.is_action_just_pressed("debug"):
		open_debug()
		
	if Input.is_action_pressed("drift"):
		drift = true
	else:
		drift = false
		
	

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
	

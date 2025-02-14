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
@export var DRIFT = 1
@export var ZOOM_DURATION = 0
@export var RESPAWN = []
@export var SPEED_BOOST = false

const MAX_STEER = 0.8
const ENGINE_POWER = 300

var drift
var old_rotation
var old_position
var old_velocity
var axis
var paused = false
var debug_open = false
var prior

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RESPAWN = [position, global_rotation_degrees]
	ui.visible = true
	pause_menu.visible = false
	debug_menu.visible = false
	#transition_screen.visibile = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("steer_right", "steer_left") * MAX_STEER, delta * 2.5)
	engine_force = Input.get_axis("pedal_accelerate", "pedal_reverse") * ENGINE_POWER
	
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	
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

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
@export var MAX_STEER = 0.9
@export var ENGINE_POWER = 500
@onready var ray: RayCast3D = $RayCast3D

@export var DRIFT = 1
var drift
var old_rotation
var old_position
var old_velocity
var axis
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
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


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if drift:
		#When the car is drifting reduces the friction on the cars wheels
		blwheel.wheel_friction_slip = 2.5
		brwheel.wheel_friction_slip = 2.5
		flwheel.wheel_friction_slip = 5.5
		frwheel.wheel_friction_slip = 5.5
		#Keeps the linear velocity at the same from the drifts start to end
		linear_velocity.z = clamp(linear_velocity.z,old_velocity.z,old_velocity.z-10)
		#Checks if the direction your pressing is the same as the directions from the start of the drift 
		if axis == -Input.get_axis("right","left"):
			#Wide drift 
			#apply_central_force(Vector3(10*axis,0,10))
			#apply_central_impulse(Vector3(3*axis,0,0))
			#Locks the axis to the start position and the given angle
			apply_torque(Vector3(0,-2*axis,0))
			global_rotation_degrees.y = clamp(global_rotation_degrees.y,[global_rotation_degrees.y,old_rotation.y].min(),[global_rotation_degrees.y,old_rotation.y].max())
		elif Input.get_axis("right","left") == 0:
			#Middle drift 
			global_rotation_degrees.y = global_rotation_degrees.y
		elif axis == Input.get_axis("right","left"):
			#Tight drift 
			apply_torque(Vector3(0,2*axis,0))
			pass
			#apply_torque_impulse(Vector3(0,0*axis,0))
			#global_rotation_degrees.y = clamp(global_rotation_degrees.y,[old_rotation.y+45*axis,old_rotation.y].min(),[old_rotation.y+45*axis,old_rotation.y].max())
	rotation_degrees.x = clamp(rotation_degrees.x,-5,5)
	rotation_degrees.z = clamp(rotation_degrees.z,-5,5)

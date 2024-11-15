extends Control

@onready var label = $Time
@onready var timer = $Timer
@onready var actual_timer : int = 0

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	actual_timer += 1
	#var hours = int(actual_timer / 60) / 60
	var minutes = int(actual_timer / 60)
	var seconds = actual_timer - minutes * 60
	var milliseconds = int(actual_timer / 1000)
	
	$Time.text = '%02d:%02d:' + str(milliseconds) % [minutes, seconds, milliseconds]

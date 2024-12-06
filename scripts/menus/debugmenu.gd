extends Control

@onready var debug_change_currentlap = $changelap
@onready var debug_change_enginepwer = $changeenginepower
@onready var debug_change_trk = $changetrack

func _ready() -> void:
	visible = false
	
	#$Label.text = str((OS.get_static_memory_usage() / 1000000))
	
func change_lap():
	debug_change_currentlap

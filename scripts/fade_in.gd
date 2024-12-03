extends CanvasLayer

signal animation_end

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false

func transition_toblack():
	color_rect.visible = true
	animation_player.play("fade_to_black")
	
func transition_tonormal():
	color_rect.visible = true
	animation_player.play("fade_to_normal")
	
func transition_titlescreen():
	color_rect.visible = true
	animation_player.play("fade_to_normal_titlescreen")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_end.emit()
	queue_free()

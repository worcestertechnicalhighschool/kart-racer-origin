extends CanvasLayer

signal animation_end

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _fade_out():
	color_rect.visible = true
	animation_player.play("fade_out")
	
func _fade_in():
	color_rect.visible = true
	animation_player.play("fade_in")
	
func _fade_in_title_screen():
	color_rect.visible = true
	animation_player.play("fade_in_title_screen")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	animation_end.emit()

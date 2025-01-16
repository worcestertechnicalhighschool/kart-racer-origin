extends CanvasLayer

signal animation_end(is_fade_out: bool)

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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_end.emit(anim_name == "fade_out")

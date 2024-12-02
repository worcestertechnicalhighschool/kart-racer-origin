extends Control

func open_debug():
	if Input.is_action_just_pressed("open_debug"):
		if $".".visible == false:
			$".".visible = not false
		elif $".".visible == true:
			$".".visible = not true

extends Control

@onready var line_edit = $"MarginContainer/VBoxContainer/LineEdit"

var expression = Expression.new()
var commands_index = 0
var commands = []
var render_zero = true

func _render_to_console(output, command=""):
	%RichTextLabel.text += "\n" + str(command) + ": " + str(output)

func _on_line_edit_text_submitted(command: String) -> void:
	commands.insert(0, command)
	
	command = command.strip_edges(true, true)
	
	if command == "clear":
		%RichTextLabel.text = _render_to_console("Console successfully cleared", "clear")
	else:
		var error = expression.parse(command)
		
		if error != OK:
			_render_to_console(expression.get_error_text())
			return
			
		var result = expression.execute([], $"../..")
		if not expression.has_execute_failed():
			_render_to_console(result, command)
		else:
			_render_to_console(expression.get_error_text(), command)
			
	line_edit.text = ""

func _on_line_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			
			if event.keycode == 4194322:
				commands_index -= 1
			elif event.keycode == 4194320:
				if not render_zero:
					commands_index += 1
				else:
					render_zero = false
			else:
				commands_index = 0
				render_zero = true
			
			if commands_index < -1 * len(commands):
				commands_index = -1
			elif commands_index >= len(commands):
				commands_index = 0

			if len(commands) > 0:
				if event.keycode == 4194320 or event.keycode == 4194322:
					line_edit.text = commands[commands_index]

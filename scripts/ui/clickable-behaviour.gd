class_name ClickableBehaviour extends Node2D

signal clicked

var mouse_button_was_down: bool

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# Cancel any input events if the mouse moves.
	if event is InputEventMouseMotion:
		mouse_button_was_down = false
		
	# Detect a click event. If we click and unclick without the mouse moving, fire a clicked signal.
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed == true:
				mouse_button_was_down = true
			elif mouse_button_was_down:
				clicked.emit()

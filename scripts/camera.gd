class_name Camera extends Camera2D

@export var zoomSpeed: float = 0.1
@export var zoomMin: float = 0.01
@export var zoomMax: float = 5
@export var dragSensitivity: float = 1

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			position -= event.relative * dragSensitivity / zoom
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoomSpeed, zoomSpeed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoomSpeed, zoomSpeed)
			
		zoom = clamp(zoom, Vector2(zoomMin, zoomMin), Vector2(zoomMax, zoomMax))

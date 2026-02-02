class_name GridArray
extends RefCounted

var array: Array
var x_size: int
var y_size: int

func _init(p_x_size: int, p_y_size: int):
	x_size = p_x_size
	y_size = p_y_size
	
	array.clear()
	array.resize(x_size * y_size)

func get_value(x: int, y: int):
	return array[(y * x_size) + x]
	
func set_value(x: int, y: int, value):
	array[(y * x_size) + x] = value

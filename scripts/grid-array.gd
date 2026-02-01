class_name GridArray
extends RefCounted

var array: Array
var x_size: int
var y_size: int

func _init(x_size: int, y_size: int):
	self.x_size = x_size
	self.y_size = y_size
	
	array.clear()
	array.resize(x_size * y_size)

func get_value(x: int, y: int):
	return array[(y * x_size) + x]
	
func set_value(x: int, y: int, value):
	array[(y * x_size) + x] = value

class_name PulseBehaviour extends Node

@export var scale: float = 1.5
@export var duration: float = 1.0

var currentScale = 1;

func _process(delta: float):
	var tween = get_tree().create_tween();
	tween.tween_property

class_name SlotController
extends Node2D

var sliver_controller: SliverController

func set_sliver(sliver: Sliver):
	if sliver_controller != null:
		clear_sliver()
	
	# Instantiate the sliver controller as a child of this one.
	var sliver_scene: Resource = load("res://scenes/sliver.tscn")
	sliver_controller = sliver_scene.instantiate()
	add_child(sliver_controller)
	
	# Update properties on the sliver controller.
	sliver_controller.sliver = sliver
	
func clear_sliver():
	sliver_controller.queue_free()
	sliver_controller = null

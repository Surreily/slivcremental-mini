class_name SlotController
extends Node2D

var sliver_controller: SliverController

func set_sliver(sliver: Sliver):
	# Clear the existing sliver first.
	clear_sliver()
	
	# Instantiate the sliver as a child of this one.
	var sliver_scene: Resource = load("res://scenes/sliver.tscn")
	sliver_controller = sliver_scene.instantiate()
	add_child(sliver_controller)
	
	# Update properties on the sliver.
	sliver_controller.sliver = sliver
	
func clear_sliver():
	if (sliver_controller != null):
		sliver_controller.queue_free()
		sliver_controller = null

class_name SliverHiveController
extends Node2D

func update_from_state() -> void:
	# Load the scene.
	var slot_scene: Resource = load("res://scenes/slot.tscn")
	
	# Calculate size of hive.
	var size_x: int = 6
	var size_y: int = 4
	
	# Add new slots to the hive.
	# TODO: This will "overlap" existing slots! Perhaps preload all slots and hide those not available instead?
	for x in size_x:
		for y in size_y:
			var slot: SlotController = slot_scene.instantiate()
			slot.position = Vector2(x * 256, y * 256)
			add_child(slot)

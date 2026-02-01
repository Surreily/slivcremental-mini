class_name SliverHiveController
extends Node2D

var slot_controllers: GridArray

func _init():
	# Set up all slots.
	slot_controllers = GridArray.new(10, 10)
	
	var slot_scene: Resource = load("res://scenes/slot.tscn")
	
	for x in 10:
		for y in 10:
			var slot: SlotController = slot_scene.instantiate()
			slot.position = Vector2(x * 256, y * 256)
			add_child(slot)
			slot_controllers.set_value(x, y, slot)

func set_sliver(sliver: Sliver):
	var slot_controller: SlotController = slot_controllers.get_value(sliver.x, sliver.y)
	slot_controller.set_sliver(sliver)

func clear_slivers():
	for x in 10:
		for y in 10:
			var slot_controller: SlotController = slot_controllers.get_value(x, y)
			slot_controller.clear_sliver()

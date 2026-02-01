class_name JsonSaver
extends RefCounted

var game_controller: GameManager

func _init(game_controller: GameManager) -> void:
	self.game_controller = game_controller

func save() -> void:
	var dictionary: Dictionary = {
		"currencies": _serialize_currencies(),
		"slivers": _serialize_slivers(),
		"skills": _serialize_skills(),
	}
	
	var json: String = JSON.stringify(dictionary)
	var file = FileAccess.open("user://bog.save", FileAccess.WRITE)
	file.store_line(json)

func _serialize_currencies() -> Dictionary:
	return {
		"sliv_points": State.currencies.sliv_points,
	}

func _serialize_slivers() -> Array:
	var slivers_data = []
	
	for x in 10:
		for y in 10:
			var slot_controller: SlotController = \
				game_controller.sliver_hive_controller.slot_controllers \
					.get_value(x, y)
			
			if (slot_controller.sliver_controller != null):
				var sliver = slot_controller.sliver_controller.sliver
				
				slivers_data.append({
					"id": sliver.id,
					"x": x,
					"y": y,
				})

	return slivers_data

func _serialize_skills() -> Array:
	var skills_data = []
	
	for skill in State.skills:
		skills_data.append(skill)
	
	return skills_data

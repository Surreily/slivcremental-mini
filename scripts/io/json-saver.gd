class_name JsonSaver
extends RefCounted

func save() -> void:
	var dictionary: Dictionary = {
		"currencies": _serialize_currencies(),
		"slivers": _serialize_slivers(),
		"sliver-hive": _serialize_sliver_hive(),
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
	
	for sliver in State.slivers:
		slivers_data.append({
			"id": sliver.id,
			"x": sliver.x,
			"y": sliver.y,
		})
	
	return slivers_data

func _serialize_sliver_hive() -> Array:
	var sliver_hive_data = []
	
	for y in 10:
		for x in 10:
			var sliver: Sliver = State.sliver_hive.get_value(x, y)
			
			if sliver != null:
				sliver_hive_data.append({
					"id": sliver.id,
					"x": x,
					"y": y,
				})
	
	return sliver_hive_data

func _serialize_skills() -> Array:
	var skills_data = []
	
	for skill in State.skills:
		skills_data.append(skill)
	
	return skills_data

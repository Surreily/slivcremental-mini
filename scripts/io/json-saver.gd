class_name JsonSaver
extends RefCounted

func save(sliver: Sliver) -> void:	
	var dictionary: Dictionary = {
		"currencies": _serialize_currencies(),
		"slivers": _serialize_slivers(),
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

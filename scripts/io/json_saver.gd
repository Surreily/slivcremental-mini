class_name JsonSaver
extends RefCounted

func _save(sliver: Sliver) -> void:
	var dictionary: Dictionary = {
		"id": sliver.id,
	}
	
	var json: String = JSON.stringify(dictionary)
	
	var file = FileAccess.open("user://bog.save", FileAccess.WRITE)
	
	var json_string = file.store_line(json)

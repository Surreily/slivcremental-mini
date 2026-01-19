class_name JsonLoader
extends RefCounted

func _load() -> Sliver:
	var file = FileAccess.open("user://bog.save", FileAccess.WRITE)
	
	var json_string = file.get_line()
	
	var json = JSON.parse_string(json_string)
	
	var id = json[0]["id"]
	
	return Sliver.new()

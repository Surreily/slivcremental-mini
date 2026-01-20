class_name JsonLoader
extends RefCounted

func load() -> void:
	# Load the saved data.
	var file = FileAccess.open("user://bog.save", FileAccess.READ)
	var json_string = file.get_line()
	var data = JSON.parse_string(json_string)
	
	# Deserialize the data.
	_deserialize_slivers(data["slivers"])

func _deserialize_slivers(slivers_data) -> void:
	var slivers: Array[Sliver] = []
	
	for sliver_data in slivers_data:
		var sliver: Sliver = Sliver.new()
		
		sliver.id = sliver_data["id"]
		sliver.x = sliver_data["x"]
		sliver.y = sliver_data["y"]
		
		slivers.append(sliver)
	
	State.slivers = slivers

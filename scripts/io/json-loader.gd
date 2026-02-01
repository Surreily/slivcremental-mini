class_name JsonLoader
extends RefCounted

var game_controller: GameManager

func _init(game_controller: GameManager) -> void:
	self.game_controller = game_controller

func load() -> void:
	# Load the saved data.
	var file = FileAccess.open("user://bog.save", FileAccess.READ)
	var json_string = file.get_line()
	var data = JSON.parse_string(json_string)
	
	# Deserialize the data.
	_deserialize_slivers(data["slivers"])
	_deserialize_sliver_hive(data["sliver-hive"])

func _deserialize_slivers(slivers_data) -> void:
	var slivers: Array[Sliver] = []
	
	for sliver_data in slivers_data:
		var sliver: Sliver = Sliver.new()
		
		sliver.id = sliver_data["id"]
		sliver.x = sliver_data["x"]
		sliver.y = sliver_data["y"]
		
		slivers.append(sliver)
	
	State.slivers = slivers

func _deserialize_sliver_hive(slivers_data) -> void:
	# Reset the hive.
	State.sliver_hive = GridArray.new(10, 10)
	
	# Add each sliver from the data into the hive array.
	for sliver_data in slivers_data:
		var sliver: Sliver = Sliver.new()
		
		sliver.id = sliver_data["id"]
		
		game_controller.sliver_hive_controller.set_sliver(sliver)
		State.sliver_hive.set_value(sliver_data["x"], sliver_data["y"], sliver)

func _deserialize_skills(skills_data) -> void:
	State.skills.clear()
	
	for skill_data in skills_data:
		State.skills.append(skill_data)

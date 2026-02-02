class_name JsonLoader
extends RefCounted

var game_controller: GameManager

func _init(p_game_controller: GameManager) -> void:
	self.game_controller = p_game_controller

func load() -> void:
	# Load the saved data.
	var file = FileAccess.open("user://bog.save", FileAccess.READ)
	var json_string = file.get_line()
	var data = JSON.parse_string(json_string)
	
	# Deserialize the data.
	_deserialize_slivers(data["slivers"])

func _deserialize_slivers(slivers_data) -> void:
	# Reset the slivers.
	game_controller.sliver_hive_controller.clear_slivers()
	
	# Add each sliver.
	for sliver_data in slivers_data:
		var x: int = sliver_data["x"]
		var y: int = sliver_data["y"]
		
		var sliver: Sliver = Sliver.new()
		sliver.id = sliver_data["id"]
		
		game_controller.sliver_hive_controller.set_sliver(sliver, x, y)

func _deserialize_skills(skills_data) -> void:
	State.skills.clear()
	
	for skill_data in skills_data:
		State.skills.append(skill_data)

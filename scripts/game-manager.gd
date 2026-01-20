class_name GameManager extends Node

signal growth_points_changed

var growthPoints: int = 0
var growthPointsPerClick: int = 1

func _increment_growth_points() -> void:
	State.currencies.sliv_points += State.statistics.growthPointsPerClick
	growth_points_changed.emit()
	
	# TODO: All following code in this method is temp testing code. Delete it!
	var sliver = Sliver.new()
	sliver.id = "69" # Nice.
	sliver.x = 0
	sliver.y = 0
	
	var saver: JsonSaver = JsonSaver.new()
	saver.save(sliver)
	
	var loader: JsonLoader = JsonLoader.new()
	loader.load()

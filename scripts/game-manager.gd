class_name GameManager extends Node

signal growth_points_changed

var skill_tree_controller: SkillTreeController
var sliver_hive_controller: SliverHiveController

var growthPoints: int = 0
var growthPointsPerClick: int = 1

func _ready() -> void:
	skill_tree_controller = $"Skill Tree"
	sliver_hive_controller = $"Sliver Hive"
	
	skill_tree_controller.update_from_state()
	
	_test_save_load()

func _test_save_load() -> void:
	
	var sliver = Sliver.new()
	sliver.id = "69" # Nice.
	sliver.x = 0
	sliver.y = 0
	
	sliver_hive_controller.set_sliver(sliver)
	
	State.sliver_hive = GridArray.new(10, 10)
	
	var saver: JsonSaver = JsonSaver.new(self)
	saver.save()
	
	var loader: JsonLoader = JsonLoader.new(self)
	loader.load()

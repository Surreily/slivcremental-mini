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
	sliver_hive_controller.update_from_state()

func _test_save_load() -> void:
	var sliver = Sliver.new()
	sliver.id = "69" # Nice.
	sliver.x = 0
	sliver.y = 0
	
	State.sliver_hive = GridArray.new(10, 10)
	State.sliver_hive.set_value(1, 1, sliver)
	
	var saver: JsonSaver = JsonSaver.new()
	saver.save()
	
	var loader: JsonLoader = JsonLoader.new(self)
	loader.load()

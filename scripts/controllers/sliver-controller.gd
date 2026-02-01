class_name SliverController
extends Node2D

var sliver: Sliver

var sliv_point_progress: float = 0
var sliv_point_target: float = 10

var sliv_point_gained_tween: Tween

var random: RandomNumberGenerator

func _ready() -> void:
	random = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	_process_sliv(delta)

func _process_sliv(delta: float) -> void:
	# Increase point progress.
	sliv_point_progress += delta
	
	# If target reached, increment sliv points and set next target.
	if (sliv_point_progress >= sliv_point_target):
		State.currencies.sliv_points += State.statistics.growthPointsPerClick
		sliv_point_progress = 0.0
		sliv_point_target = random.randf_range(3.0, 15.0)
		
		if (sliv_point_gained_tween != null):
			sliv_point_gained_tween.stop()
			
		scale = Vector2(1.2, 1.2)
		sliv_point_gained_tween = get_tree().create_tween()
		sliv_point_gained_tween.tween_property(self, "scale", Vector2.ONE, 0.25)

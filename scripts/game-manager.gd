class_name GameManager extends Node

signal growth_points_changed

var growthPoints: int = 0
var growthPointsPerClick: int = 1

func _increment_growth_points() -> void:
	Currencies.growthPoints += Stats.growthPointsPerClick
	growth_points_changed.emit()

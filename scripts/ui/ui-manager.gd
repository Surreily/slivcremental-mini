class_name UiManager extends Node

@export var gameManager: GameManager
@export var growthPointsLabel: Label

func _process(delta: float) -> void:
	growthPointsLabel.text = str(State.currencies.sliv_points)

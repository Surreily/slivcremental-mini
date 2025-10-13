@tool

class_name SkillNode extends Node2D

signal clicked

@export var linkedSkillNodes: Array[SkillNode] = []
@export var costInGrowthPoints: int = 0
@export var skillTexture: Texture2D = null

var unlocked: bool = false
var purchased: bool = false

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	
	# Rotate the background and border a random amount (for visual variance).
	$"Background Sprite".rotate(rng.randf_range(0, PI * 2))
	$"Border Sprite".rotate(rng.randf_range(0, PI * 2))
	
	if (skillTexture != null):
		$"Skill Sprite".texture = skillTexture

func _show_background() -> void:
	$"Background Sprite".visible = true
	
func _hide_background() -> void:
	$"Background Sprite".visible = false

func _on_click() -> void:
	if (unlocked):
		return

	unlocked = true
	clicked.emit()

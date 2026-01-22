@tool

class_name SkillNodeController
extends Node2D

signal clicked

@export var linkedSkillNodes: Array[SkillNodeController] = []
@export var costInGrowthPoints: int = 0
@export var skillTexture: Texture2D = null
@export var key: String = ""

var parent_node: SkillNodeController = null
var child_node_connections: Array[Line2D] = []
var unlocked: bool = false
var purchased: bool = false

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	
	# Rotate the background and border a random amount (for visual variance).
	$"Background Sprite".rotate(rng.randf_range(0, PI * 2))
	$"Border Sprite".rotate(rng.randf_range(0, PI * 2))
	
	# Update the skill sprite.
	if (skillTexture != null):
		$"Skill Sprite".texture = skillTexture

func update_from_state() -> void:
	# Get the purchase status of relevant nodes in the tree (this one and its parent).
	var is_purchased_in_state: bool = State.skills.keys.find(key) != -1
	var is_parent_purchased_in_state: bool = \
		parent_node == null || \
		State.skills.keys.find(parent_node.key) != -1
	
	# Update visibility of sprites based on purchase status.
	$"Border Sprite".visible = is_parent_purchased_in_state
	$"Skill Sprite".visible = is_parent_purchased_in_state

	for connection in child_node_connections:
		connection.visible = is_purchased_in_state
		
	$"Background Sprite".visible = is_purchased_in_state

func on_unlock() -> void:
	# Update this node.
	update_from_state()
	
	# Update linked nodes.
	for node in linkedSkillNodes:
		node.update_from_state()
	
func _show_background() -> void:
	$"Background Sprite".visible = true
	
func _hide_background() -> void:
	$"Background Sprite".visible = false

func _on_click() -> void:
	if (unlocked):
		return

	State.skills.keys.append(key)

	unlocked = true
	clicked.emit()
	
	on_unlock()

@tool

class_name SkillTreeController extends Node

@export var gameManager: GameManager
@export var lineTexture: Texture2D

func _ready() -> void:
	for child in get_children():
		if is_instance_of(child, SkillNodeController):
			link_nodes(child)
			
func _process(delta: float) -> void:
	if (Engine.is_editor_hint()):
		pass # TODO: Update child endpoints
		#for child in get_children():
			#if is_instance_of(child, SkillNode):
				#link_nodes(child)

func update_from_state() -> void:
	for child in get_children():
		if is_instance_of(child, SkillNodeController):
			var node: SkillNodeController = child as SkillNodeController
			node.update_from_state()
			
func unlock_skill(key: String) -> void:
	for child in get_children():
		if is_instance_of(child, SkillNodeController):
			var skill_node_controller: SkillNodeController = child as SkillNodeController
			skill_node_controller.unlock()

func reset_skills() -> void:
	for child in get_children():
		if is_instance_of(child, SkillNodeController):
			var skill_node_controller: SkillNodeController = child as SkillNodeController
			skill_node_controller.lock()
	
func link_nodes(parent: SkillNodeController):
	for child in parent.linkedSkillNodes:
		if child != null:
			link_skill_tree_nodes(parent, child)

func link_skill_tree_nodes(parent: SkillNodeController, child: SkillNodeController) -> void:
	# Add a reference to the parent from the child.
	child.parent_node = parent
	
	# Calculate the line's endpoints.
	var vector = child.position - parent.position
	vector = vector.normalized()
	vector = vector * 64
	
	var point_1 = parent.position + vector
	var point_2 = child.position - vector
	
	# Build the line.
	var line: Line2D = Line2D.new()
	line.add_point(point_1)
	line.add_point(point_2)
	line.texture = lineTexture
	line.texture_mode = Line2D.LINE_TEXTURE_TILE
	line.width = 32
	add_child(line)
	
	parent.child_node_connections.append(line)

func _increment_growth_points_1() -> void:
	State.statistics.growthPointsPerClick += 1

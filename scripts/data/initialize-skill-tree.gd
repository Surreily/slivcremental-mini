class_name InitializeSkillTree
extends RefCounted

var skill_tree_controller: SkillTreeController

func _init(p_skill_tree_controller: SkillTreeController) -> void:
	skill_tree_controller = p_skill_tree_controller

func initialize() -> void:
	# Prepare skill node scene.
	var _skill_node_scene = load("res://scenes/skill-node.tscn")

	# Open the XML file.
	var _parser = XMLParser.new()
	_parser.open("res://data/skills.xml")

	# Prepare variables to keep track of where we are in the XML tree.
	var _depth = 0 # Keep track of how deep we are in the XML tree.
	var _current_skill: SkillNodeController # Keep track of the skill we're currently modifying.
	var _skill_nodes: Dictionary = {} # Keep track of all skill nodes we find.
	var _connections: Dictionary = {} # Keep track of all connections we find.
	var _textures: Dictionary = {} # Keep a dictionary of textures to ensure we don't "double-load" any.

	# Read the XML document through to the end.
	while _parser.read() != ERR_FILE_EOF:

		# Handle opening elements.
		if _parser.get_node_type() == XMLParser.NODE_ELEMENT:

			# The Skills node is just a container; don't do anything.
			if _parser.get_node_name() == "Skills":
				if !_parser.is_empty():
					assert(_depth == 0)
					_depth = 1

			# The Skill node represents an individual skill. Create it and add it to the skill tree.
			elif _parser.get_node_name() == "Skill":
				if !_parser.is_empty():
					assert(_depth == 1)
					_depth = 2

				_current_skill = _skill_node_scene.instantiate()

				for i in _parser.get_attribute_count():
					if _parser.get_attribute_name(i) == "Key":
						_current_skill.key = _parser.get_attribute_value(i)
						_skill_nodes.set(_parser.get_attribute_value(i), _current_skill)
					elif _parser.get_attribute_name(i) == "Title":
						_current_skill.title = _parser.get_attribute_value(i)
					elif _parser.get_attribute_name(i) == "Description":
						_current_skill.description = _parser.get_attribute_value(i)
					elif _parser.get_attribute_name(i) == "X":
						_current_skill.position.x = _parser.get_attribute_value(i) as float * 128
					elif _parser.get_attribute_name(i) == "Y":
						_current_skill.position.y = _parser.get_attribute_value(i) as float * 128
					elif _parser.get_attribute_name(i) == "Icon":
						var _resource_path: String = "res://graphics/skills/" + _parser.get_attribute_value(i) + ".png"

						if _textures.has(_resource_path):
							_current_skill.set_icon(_textures.get(_resource_path))
						else:
							var _image: Image = Image.load_from_file(_resource_path)
							var _texture: Texture2D = ImageTexture.create_from_image(_image)
							_texture.create_from_image(_texture)
							_textures.set(_resource_path, _texture)
							_current_skill.set_icon(_texture)

					else:
						assert(false, "Unrecognised attribute name " + _parser.get_attribute_name + ".")
				
				skill_tree_controller.add_child(_current_skill)

			# The Connections node is just a container; don't do anything.
			elif _parser.get_node_name() == "Connections":
				if !_parser.is_empty():
					assert(_depth == 2)
					_depth = 3

			# The Connection node describes a connection from the current node to another one.
			elif _parser.get_node_name() == "Connection":
				if !_parser.is_empty():
					assert(_depth == 3)
					_depth = 4

				for i in _parser.get_attribute_count():
					if _parser.get_attribute_name(i) == "Key":
						_connections.get_or_add(_current_skill.key, []).append(_parser.get_attribute_value(i))
					else:
						assert(false, "Unrecognised attribute name " + _parser.get_attribute_name + ".")
		
		# Whenever we encounter the closing tag for an element, decrease our depth.
		elif _parser.get_node_type() == XMLParser.NODE_ELEMENT_END:

			if _parser.get_node_name() == "Skills":
				assert(_depth == 1)
				_depth = 0

			elif _parser.get_node_name() == "Skill":
				assert(_depth == 2)
				_depth = 1

			elif _parser.get_node_name() == "Connections":
				assert(_depth == 3)
				_depth = 2

			elif _parser.get_node_name() == "Connection":
				assert(_depth == 4)
				_depth = 3

	# Ensure depth is zero. Any other number would indicate invalid XML.
	assert(_depth == 0)
	
	# Link up nodes.
	for _key in _connections.keys():
		var _key_skill_node: SkillNodeController = _skill_nodes[_key]
		
		for _value in _connections[_key]:
			var _value_skill_node: SkillNodeController = _skill_nodes[_value]
			_key_skill_node.linkedSkillNodes.append(_value_skill_node)

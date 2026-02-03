class_name InitializeSkillTree
extends RefCounted

var skill_tree_controller: SkillTreeController

func _init(p_skill_tree_controller: SkillTreeController) -> void:
	skill_tree_controller = p_skill_tree_controller

func initialize() -> void:
	# Prepare skill node scene.
	var _skill_node_scene = load("res://scenes/skill-node.tscn")

	# Prepare texture dictionary.
	var _texture_dictionary: Dictionary = {}

	var _parser = XMLParser.new()
	_parser.open("res://data/skills.xml")

	var _depth = 0

	var _current_skill: SkillNodeController

	while _parser.read() != ERR_FILE_EOF:

		if _parser.get_node_type() == XMLParser.NODE_ELEMENT:

			if _parser.get_node_name() == "Skills":
				if !_parser.is_empty():
					assert(_depth == 0)
					_depth = 1

			elif _parser.get_node_name() == "Skill":
				if !_parser.is_empty():
					assert(_depth == 1)
					_depth = 2

				_current_skill = _skill_node_scene.instantiate()

				for i in _parser.get_attribute_count():
					if _parser.get_attribute_name(i) == "Title":
						_current_skill.title = _parser.get_attribute_value(i)
					elif _parser.get_attribute_name(i) == "Description":
						_current_skill.description = _parser.get_attribute_value(i)
					elif _parser.get_attribute_name(i) == "X":
						_current_skill.position.x = _parser.get_attribute_value(i) as float * 128
					elif _parser.get_attribute_name(i) == "Y":
						_current_skill.position.y = _parser.get_attribute_value(i) as float * 128
					elif _parser.get_attribute_name(i) == "Icon":
						var _resource_path: String = "res://graphics/skills/" + _parser.get_attribute_value(i) + ".png"

						if (_texture_dictionary.has(_resource_path)):
							_current_skill.set_icon(_texture_dictionary.get(_resource_path))
						else:
							var _image: Image = Image.load_from_file(_resource_path)
							var _texture: Texture2D = ImageTexture.create_from_image(_image)
							_texture.create_from_image(_texture)
							_texture_dictionary.set(_resource_path, _texture)
							_current_skill.set_icon(_texture)
				
				skill_tree_controller.add_child(_current_skill)

			elif _parser.get_node_name() == "Connections":
				if !_parser.is_empty():
					assert(_depth == 2)
					_depth = 3

			elif _parser.get_node_name() == "Connection":
				if !_parser.is_empty():
					assert(_depth == 3)
					_depth = 4
		
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

	assert(_depth == 0)

class_name SliverManager extends Node

signal clicked

var scale: Vector2
var tween: Tween

func _ready():
	scale = $Sprite.scale
	print("Ready to sliv!")
	
func _on_collision_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		print("Sliv");

func _on_clicked() -> void:
	if tween != null:
		tween.stop()
		
	$Sprite.scale = scale * 1.1
	
	tween = get_tree().create_tween()
	tween.tween_property($Sprite, "scale", scale, 0.25)

	clicked.emit()

extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($ColorRect, "color", Color(0, 0, 0, 0), 1)

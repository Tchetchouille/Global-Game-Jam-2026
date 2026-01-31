extends Sprite2D
@export var modulation : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(modulation.x, modulation.y, modulation.z)

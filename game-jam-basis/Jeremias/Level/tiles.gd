extends TileMapLayer

@onready var rgb = $"../.."
var modulation = [
	Vector3(0.6, 0.07, 0.3),
	Vector3(0.3, 0.6, 0.07),
	Vector3(0.07, 0.3, 0.6)
]
@export var layer : int

func _process(delta: float) -> void:
	print(rgb.mask)
	if rgb.mask == layer:
		modulate.a = 0.2
	else:
		modulate.a = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(modulation[layer].x, modulation[layer].y, modulation[layer].z)

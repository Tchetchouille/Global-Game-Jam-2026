extends Area2D

signal death_by_wall

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_overlapping_bodies():
		death_by_wall.emit()

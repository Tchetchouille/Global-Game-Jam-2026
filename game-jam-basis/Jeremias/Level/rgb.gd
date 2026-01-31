extends Node2D
var mask = 3

func change_mask():
	mask += 1
	if mask > 3:
		mask = 0

func _on_player_change_rgb() -> void:
	change_mask()

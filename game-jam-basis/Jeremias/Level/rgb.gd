extends Node2D
var mask = 0

func _on_player_change_rgb(player_mask) -> void:
	print("change : " + str(player_mask))
	mask = player_mask

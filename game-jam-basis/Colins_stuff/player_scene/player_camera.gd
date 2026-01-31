extends Camera2D

var following_player = true
var smooth_y = true


func _process(delta: float) -> void:
	if not following_player:
		if not smooth_y:
			global_position.y = -850 + $"..".global_position.y
		global_position.x = $"..".global_position.x

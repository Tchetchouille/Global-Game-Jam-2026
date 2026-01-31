extends Node2D
var mask = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_z"):
		change_mask()


func change_mask():
	if mask < 3:
		get_child(mask).visible = true
	mask += 1
	if mask > 3:
		mask = 0
	if mask < 3:
		get_child(mask).visible = false

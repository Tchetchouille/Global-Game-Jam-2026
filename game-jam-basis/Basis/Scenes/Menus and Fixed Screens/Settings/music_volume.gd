extends HBoxContainer


func _on_h_slider_value_changed(value: float) -> void:
	MenuMusic.volume_linear = value / 100

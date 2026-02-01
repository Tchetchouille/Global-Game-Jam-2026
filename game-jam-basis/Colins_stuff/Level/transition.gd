extends Area2D

@onready var color_rect = $"../CanvasLayer/ColorRect"
func _on_body_entered(body: Node2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,1),0.5)
	$"Timer".start()
	


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Jeremias/Level/Boss Battle/boss_battle.tscn")

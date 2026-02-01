extends Area2D

var dead = false
var can_explode_timer = false
var can_explode_layer = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_overlapping_bodies() and not dead and can_explode_timer and can_explode_layer:
		$"..".stop = true
		dead = true
		$"../Sprite2D2".queue_free()
		$"../AnimatedSprite2D".play("explode")
		await $"../AnimatedSprite2D".animation_finished
		$"..".queue_free()


func _on_activation_timer_timeout() -> void:
	can_explode_timer = true

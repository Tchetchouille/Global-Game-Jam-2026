extends Area2D

var dead = false
var can_explode_timer = false
var can_explode_layer = true
@onready var timer: Timer = $"../Timer"


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


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not dead and can_explode_layer:
		body.die()
		print("You died")
		Engine.time_scale = 0.7
		timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene() # Replace with function body.
		

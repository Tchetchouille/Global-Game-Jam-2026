extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.get_name()=="Player":
		$"../Killzone".queue_free()
		$"Timer".start()


func _on_timer_timeout() -> void:
	#Transition
	pass # Replace with function body.

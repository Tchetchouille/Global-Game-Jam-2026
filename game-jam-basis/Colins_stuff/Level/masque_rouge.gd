extends Area2D
@onready var label: Label = $"../LabelRouge"
@onready var text_timer: Timer = $"../TextTimer"
var APPEAR = 1
var ENTERED = false
var picked = false

func _on_body_entered(body: Node2D) -> void:
	if !picked:
		APPEAR = 1
		ENTERED = true
		label.text = "Récupérer (E)"
		label.self_modulate.a =0.01
		text_timer.start()
		pass # Replace with function body.
	
func _process(delta: float) -> void:
	if !picked:
		if Input.is_action_just_pressed("interact") and ENTERED:
			$"../Player".unlocked_masks+=1
			$"../LabelRouge".text = "Appuie sur SHIFT pour changer de masque"
			APPEAR = -1
			$Sprite2D.queue_free()
			picked = true
	if label.self_modulate.a > 0:
		label.self_modulate.a += 0.03*APPEAR
	
func _on_body_exited(body: Node2D) -> void:
	APPEAR = -1
	ENTERED = false
 


func _on_text_timer_timeout() -> void:
	APPEAR = -1

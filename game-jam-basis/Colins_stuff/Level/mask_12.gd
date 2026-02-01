extends Area2D

@onready var label: Label = $"Label"
@onready var text_timer: Timer = $"../TextTimer"
var APPEAR = 1
var ENTERED = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and ENTERED:
		APPEAR = 1
		label.text = "Des popcorns ça ne vaut pas des amis."
		label.self_modulate.a = 0.01
	if label.self_modulate.a > 0:
		label.self_modulate.a += 0.03*APPEAR
	


func _on_body_entered(body: Node2D) -> void:
	APPEAR = 1
	ENTERED = true
	label.text = "Lire (E)"
	label.self_modulate.a =0.01
	text_timer.start()
func _on_body_exited(body: Node2D) -> void:
	APPEAR = -1
	ENTERED = false
 


func _on_text_timer_timeout() -> void:
	APPEAR = -1

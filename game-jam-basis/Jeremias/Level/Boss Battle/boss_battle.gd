extends Node2D

@onready var tween_time = $TransitionTimer.wait_time
var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_transition_to_fight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		camera = body.get_node("Camera2D")
		$TransitionTimer.start()
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "zoom", Vector2(0.3, 0.3), tween_time)
		camera.following_player = false


func _on_transition_timer_timeout() -> void:
	if camera != null:
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "global_position:y", 0, tween_time)
		await tween.finished
		camera.smooth_y = false

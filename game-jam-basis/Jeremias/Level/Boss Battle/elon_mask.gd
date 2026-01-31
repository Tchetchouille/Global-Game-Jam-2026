extends CharacterBody2D

var rng = RandomNumberGenerator.new()

const MAX_X_SPEED = 300
const MAX_Y_SPEED = 300


func _physics_process(_delta: float) -> void:
	var x_acc = rng.randf_range(-40.0, 40.0)
	var y_acc = rng.randf_range(-40.0, 40.0)
	velocity.x += x_acc
	velocity.y += y_acc
	if velocity.x > 300:
		velocity.x = 300
	if velocity.y > 300:
		velocity.y = 300

	move_and_slide()

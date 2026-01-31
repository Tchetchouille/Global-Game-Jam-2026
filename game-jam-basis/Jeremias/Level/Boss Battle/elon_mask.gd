extends CharacterBody2D

var rng = RandomNumberGenerator.new()

const MAX_X_SPEED = 300
const MAX_Y_SPEED = 300

func _ready() -> void:
	$AnimatedSprite2D.play("elon")

func _physics_process(_delta: float) -> void:
	var x_acc = rng.randf_range(-40.0, 40.0)
	var y_acc = rng.randf_range(-40.0, 40.0)
	velocity.x += x_acc
	velocity.y += y_acc
	if velocity.x > MAX_X_SPEED:
		velocity.x = MAX_X_SPEED
	elif velocity.x < -MAX_X_SPEED:
		velocity.x = -MAX_X_SPEED
	if velocity.y > MAX_Y_SPEED:
		velocity.y = MAX_Y_SPEED
	elif velocity.y < -MAX_Y_SPEED:
		velocity.y = -MAX_Y_SPEED
	move_and_slide()

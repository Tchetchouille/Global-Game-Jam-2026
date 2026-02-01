extends CharacterBody2D

var rng = RandomNumberGenerator.new()

const MAX_X_SPEED = 300
const MAX_Y_SPEED = 300
var min_x_speed = -MAX_X_SPEED
var max_x_speed = MAX_X_SPEED
var min_y_speed = -MAX_Y_SPEED
var max_y_speed = MAX_Y_SPEED

func _ready() -> void:
	$AnimatedSprite2D.play("elon")

func _physics_process(_delta: float) -> void:
	check_obstacles()
	var x_acc = rng.randf_range(-40.0, 40.0)
	var y_acc = rng.randf_range(-40.0, 40.0)
	velocity.x += x_acc
	velocity.y += y_acc
	if velocity.x > max_x_speed:
		velocity.x = max_x_speed
	elif velocity.x < min_x_speed:
		velocity.x = min_x_speed
	if velocity.y > max_y_speed:
		velocity.y = max_y_speed
	elif velocity.y < min_y_speed:
		velocity.y = min_y_speed
	move_and_slide()

func check_obstacles():
	if $ObstacleCheck/LeftCheck.is_colliding():
		min_x_speed = 0
	if $ObstacleCheck/RightCheck.is_colliding():
		max_x_speed = 0
	if $ObstacleCheck/UpCheck.is_colliding():
		min_y_speed = 0
	if $ObstacleCheck/DownCheck.is_colliding():
		max_y_speed = 0

func attack():
	pass

func _on_attack_timer_timeout() -> void:
	pass # Replace with function body.

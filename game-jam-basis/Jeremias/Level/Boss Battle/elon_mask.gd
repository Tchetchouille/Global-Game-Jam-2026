extends CharacterBody2D

var rng = RandomNumberGenerator.new()

var rgb_melon = preload("res://Jeremias/Level/Boss Battle/rgb_melon.tscn")
@onready var player = $"../Player"

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
	else:
		min_x_speed = -MAX_X_SPEED
	if $ObstacleCheck/RightCheck.is_colliding():
		max_x_speed = 0
	else:
		max_x_speed = MAX_X_SPEED
	if $ObstacleCheck/UpCheck.is_colliding():
		min_y_speed = 0
	else:
		min_y_speed = -MAX_Y_SPEED
	if $ObstacleCheck/DownCheck.is_colliding():
		max_y_speed = 0
	else:
		max_y_speed = MAX_Y_SPEED

func attack():
	pass

func _on_attack_timer_timeout() -> void:
	var projectile = rgb_melon.instantiate()
	projectile.global_position = position
	projectile.direction = (player.global_position - global_position)
	projectile.direction.normalized()
	print(projectile.direction)
	var layer = rng.randi_range(1, 3)
	projectile.layer = layer
	match layer:
		1:
			$"../RGB/R".add_child(projectile)
		2:
			$"../RGB/G".add_child(projectile)
		3:
			$"../RGB/B".add_child(projectile)

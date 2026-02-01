extends CharacterBody2D

var rng = RandomNumberGenerator.new()

var rgb_melon = preload("res://Jeremias/Level/Boss Battle/rgb_melon.tscn")
var explosion = preload("res://Jeremias/Level/Boss Battle/macron_explosion.tscn")
@onready var player = $"../Player"

const MAX_X_SPEED = 300
const MAX_Y_SPEED = 300
var min_x_speed = -MAX_X_SPEED
var max_x_speed = MAX_X_SPEED
var min_y_speed = -MAX_Y_SPEED
var max_y_speed = MAX_Y_SPEED
var health = 100
var nb_explosions = 10

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


func _on_melon_check_body_entered(body: Node2D) -> void:
	print(body.get_node("DeathByWall").can_explode_timer)
	if body.get_node("DeathByWall").can_explode_timer:
		health -= 100
		if health <= 0:
			die()

func die():
	$MacronExplosion.start()
	

func _on_macron_explosion_timeout() -> void:
	if nb_explosions > 0:
		var new_explosion = explosion.instantiate()
		new_explosion.position += Vector2(rng.randi_range(-200, 200), rng.randi_range(-200, 200)) 
		add_child(new_explosion)
		var random_scale = rng.randi_range(0.1, 1)
		new_explosion.scale = Vector2(random_scale, random_scale)
		new_explosion.play("default")
		nb_explosions -= 1
	elif nb_explosions == 0:
		var tween = get_tree().create_tween()
		tween.tween_property($CanvasLayer/ColorRect, "color", Color(0, 0, 0, 1), 0.5)
		$VictoryTimer.start()
		nb_explosions -= 1

func _on_victory_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Jeremias/Level/Boss Battle/victory.tscn")

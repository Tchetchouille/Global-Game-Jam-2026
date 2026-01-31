extends CharacterBody2D

var target = null
var sees_player = false
var direction = 1
@onready var player_detection = [
	$PlayerCheck/PlayerCheckTop, 
	$PlayerCheck/PlayerCheckMiddleTop, 
	$PlayerCheck/PlayerCheckMiddle, 
	$PlayerCheck/PlayerCheckMiddleBottom, 
	$PlayerCheck/PlayerCheckBottom
]
@onready var obstacle_detection = [
	$ObstacleCheck/ObstacleCheckTop, 
	$ObstacleCheck/ObstacleCheckMidle, 
	$ObstacleCheck/ObstacleCheckBottom
]

@export var roaming_speed = 100
@export var pursuing_speed = 200

# Possible states: idle / falling / roaming / pursuing
var state = "idle"

func _physics_process(delta: float) -> void:
	set_state()
	process_state(delta)
	move_and_slide()

func set_state():
	if $PursuingTimer.is_stopped():
		# If not on floor, falls
		if not is_on_floor():
			state = "falling"
		else:
			if check_player():
				state = "pursuing"
			else:
				if $FloorCheck.is_colliding() and check_obstacles() == false:
					state = "roaming"
				else:
					state = "idle"

func process_state(d):
	match state:
		"idle":
			velocity.x = 0
			if $IdleTimer.is_stopped():
				$IdleTimer.start()
		"falling":
			velocity += get_gravity() * d
		"roaming":
			$IdleTimer.stop()
			velocity.x = -1 * roaming_speed * direction
		"pursuing":
			if $PursuingTimer.is_stopped():
				$PursuingTimer.start()
			turn_towards_player()
			velocity.x = -1 * pursuing_speed * direction
	print(state)

func check_obstacles():
	for ray in obstacle_detection:
		if ray.is_colliding():
			return true
	return false

func check_player():
	for ray in player_detection:
		if ray.is_colliding():
			target = ray.get_collider()
			return true
	return false

func turn_towards_player():
	print(target)
	var dir = (position.x - target.position.x) * direction
	if dir < 0:
		scale.x = -1 * scale.x
		direction = -direction

func _on_idle_timer_timeout() -> void:
	state = "roaming"
	scale.x = -1 * scale.x
	direction = -direction

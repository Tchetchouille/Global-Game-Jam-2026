extends CharacterBody2D

var sees_player = false
var direction = 1

@export var speed = -100

# Possible states: idle / falling / roaming / pursuing
var state = "idle"

func _physics_process(delta: float) -> void:
	# If not on floor, falls
	if not is_on_floor():
		state = "falling"
	else:
		if sees_player:
			state = "pursue"
		else:
			if $FloorCheck.is_colliding():
				state = "roaming"
			else:
				state = "idle"
	print(state)
	match state:
		"idle":
			velocity.x = 0
			if $IdleTimer.is_stopped():
				$IdleTimer.start()
		"falling":
			velocity += get_gravity() * delta
		"roaming":
			$IdleTimer.stop()
			velocity.x = speed * direction
		"pursuing":
			pass
	move_and_slide()

func _on_idle_timer_timeout() -> void:
	state = "roaming"
	scale.x = -1 * scale.x
	direction = -direction

extends CharacterBody2D


const SPEED = 1200.0
const ACCELERATION = 450.0
const DECELERATION = 2250.0
const JUMP_VELOCITY = -750.0
var dying = false
var mask = 3
var next_mask = 0
signal change_RGB

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
 
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if (direction < 0 and velocity.x > 0) or (direction > 0 and velocity.x < 0):
			velocity.x = move_toward(velocity.x, 0, DECELERATION*delta*1.5)
		else:
			velocity.x = move_toward(velocity.x, SPEED*direction, ACCELERATION*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION*delta)
	
	# Mask change
	if Input.is_action_just_pressed("change_z"):
		change_mask()
	
	# Gérer la direction du player
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Gestion des animations
	if is_on_floor() and !dying:
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	elif dying:
		animated_sprite.play("death")
	else:
		animated_sprite.play("jump")
	move_and_slide()

func die():
	dying = true


func change_mask():
	if $MaskCheck.has_overlapping_bodies() == false:
		if mask < 3:
			set_collision_mask_value(10 + mask, true)
			
		if next_mask < 3:
			$MaskCheck.set_collision_mask_value(10 + next_mask, true)
		mask = next_mask
		next_mask += 1
		if next_mask > 3:
			next_mask = 0
		if mask < 3:
			set_collision_mask_value(10 + mask, false)
		if next_mask < 3:
			$MaskCheck.set_collision_mask_value(10 + next_mask, false)
		change_RGB.emit()
	else:
		print("Something blocks you...")

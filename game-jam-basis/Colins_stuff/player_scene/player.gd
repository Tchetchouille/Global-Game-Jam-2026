extends CharacterBody2D

@export var unlocked_masks = 0

const SPEED = 1200.0
const ACCELERATION = 450.0
const DECELERATION = 2250.0
const JUMP_VELOCITY = -750.0
var dying = false
var mask = 3
var next_mask = 0
var mask_textures = [
	null,
	preload("res://Colins_stuff/sprites/mask_red.png"),
	preload("res://Colins_stuff/sprites/mask_green.png"),
	preload("res://Colins_stuff/sprites/mask_blue.png")
]
var filter_colors = [
	Color(0.0, 0.0, 0.0, 0.0),
	Color(0.72, 0.12, 0.28, 0.3),
	Color(0.28, 0.72, 0.12, 0.3),
	Color(0.12, 0.28, 0.72, 0.3),
]
var mask_musics = [
	null,
	RMusic,
	GMusic,
	BMusic
]
signal change_RGB(current_mask)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	change_mask()

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
		$MaskSprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		$MaskSprite.flip_h = true
	
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
	$MaskSprite.visible = false

func change_mask():
	if $MaskCheck.has_overlapping_bodies() == false:
		if mask > 0:
			set_collision_mask_value(9 + mask, true)
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(mask_musics[mask], "volume_linear", 1, 0.2)
		if next_mask > 0:
			$MaskCheck.set_collision_mask_value(9 + next_mask, true)
		mask = next_mask
		next_mask += 1
		if next_mask > unlocked_masks:
			next_mask = 0
		if mask > 0:
			set_collision_mask_value(9 + mask, false)
			var tween = get_tree().create_tween()
			tween.parallel().tween_property(mask_musics[mask], "volume_linear", 0, 0.2)
		if next_mask > 0:
			$MaskCheck.set_collision_mask_value(9 + next_mask, false)
		change_RGB.emit(mask)
	else:
		print("Something blocks you...")
	$MaskSprite.texture = mask_textures[mask]
	$Camera2D/CanvasLayer/Filter.color = filter_colors[mask]

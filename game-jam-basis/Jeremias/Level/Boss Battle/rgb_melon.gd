extends CharacterBody2D

@onready var rgb = $"../.."

var rng = RandomNumberGenerator.new()

var modulation = [
	Vector3(0.0, 0.00, 0.0),
	Vector3(0.6, 0.07, 0.3),
	Vector3(0.3, 0.6, 0.07),
	Vector3(0.07, 0.3, 0.6)
]

const SPEED = 0.5
var direction : Vector2
var bounce_strength = 1.0
var layer : int
var stop = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var watermelon = rng.randi_range(0, 1)
	if watermelon:
		$AnimatedSprite2D.play("watermelon")
	else:
		$AnimatedSprite2D.play("melon")
	var my_random_number = rng.randf_range(-10.0, 10.0)
	velocity = direction * rng.randf_range(0.1, SPEED)
	modulate = Color(modulation[layer].x, modulation[layer].y, modulation[layer].z)
	set_collision_mask_value(9 + layer, true)

func _process(delta: float) -> void:
	if rgb.mask == layer:
		modulate.a = 0.2
		$DeathByWall.can_explode_layer = false
	else:
		modulate.a = 1
		$DeathByWall.can_explode_layer = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not stop:
		rotate(0.01)
		# from: https://www.reddit.com/r/godot/comments/14iqc6l/move_and_slide_and_bounce_in_godot_4/
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal()) * bounce_strength

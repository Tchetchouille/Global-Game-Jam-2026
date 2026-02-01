extends CharacterBody2D

const SPEED = 0.5

var direction : Vector2
var bounce_strength = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = direction * SPEED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotate(20)
	# from: https://www.reddit.com/r/godot/comments/14iqc6l/move_and_slide_and_bounce_in_godot_4/
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * bounce_strength

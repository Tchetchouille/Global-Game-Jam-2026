extends Area2D

var dial = [
	"Qui es-tu ?! Comment oses-tu venir te mesure à MOI ? Le grand Elon Mask !",
	"Ne vois-tu pas la beauté du paysage que j'ai permis de créer ?",
	"Je me suis fait tout seul et je reste travailler plus longtemps que mes employé·es !",
	"Mais si tu es arrivé jusque là, tu as des compétences que je n'ai pas !",
	"Péris donc sous la puissance des Melons Mask ! Mouhaha HAHAHAHA !",
	""
]
var player = null
var timeout = false
var dia_index = 0

func _process(delta: float) -> void:
	if timeout:
		$"Dialog".text = dial[dia_index]
		if dia_index < len(dial)-1:
			if Input.is_action_just_pressed("interact"):
				print("Oui")
				dia_index+=1
		else:
			print("break")
			player.can_move = true
			queue_free()


func _on_body_entered(body: Node2D) -> void:
	player = body
	print("Fonctionne" + str(body))
	if body.has_method("change_mask"):
		body.can_move = false
		print("Fonctionne")
		var animated_sprite = null
		for child in body.get_children():
			if child is AnimatedSprite2D:
				animated_sprite = child
		#animated_sprite.pause()
		animated_sprite.play("walk")
		body.velocity.x = 300.0
		$Timer.start()


func _on_timer_timeout() -> void:
	timeout = true
	player.velocity.x=0.0
	print("Fonctionne") # Replace with function body.

extends Area2D


const PUSH_FORCE = 5


func _on_body_entered(body):
	if body.name == "Player":
		var direction = (body.position - position).normalized()
		
		position.x -= direction.x * PUSH_FORCE

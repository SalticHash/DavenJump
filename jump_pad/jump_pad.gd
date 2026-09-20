extends Area2D


var activated: bool = false


func _on_body_entered(body: Node2D) -> void:
	if activated: return
	activated = true
	$AnimationPlayer.play("bounce")

	body.bounce()

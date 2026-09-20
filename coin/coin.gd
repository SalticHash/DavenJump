extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if !visible: return
	hide()
	body.coins += 1
	queue_free()
	

func _screen_exited() -> void:
	queue_free()

extends Tile

var health: int = 3

func _ready() -> void:
	$Sprite.animation = "break"

func step_on() -> void:
	if health <= 0: return
	$Sprite.frame += 1
	health -= 1
	if health <= 0:
		$Collision.set_deferred("disabled", true)


func _screen_exited() -> void:
	queue_free()

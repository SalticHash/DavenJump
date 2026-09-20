extends Tile

var health: int = 3

func randomize_health(move_chance: float):
	health = snappedi(remap(move_chance, 0.25, 0.8, 3, 1), 1)

func _ready() -> void:
	$Sprite.animation = "break"
	$Sprite.frame = 3 - health

func step_on(body) -> void:
	if body.velocity.y < 0: return
	if body.global_position.y + 37.0 > global_position.y - 3.0: return
	if health <= 0: return
	$Break.play()
	$Sprite.frame += 1
	health -= 1
	if health <= 0:
		$Collision.set_deferred("disabled", true)


func _screen_exited() -> void:
	queue_free()

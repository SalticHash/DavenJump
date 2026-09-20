extends StaticBody2D
class_name Tile

@export var move: bool = false
@export var speed: float = 32.0
@export var direction: int = 1
@export var coin: bool = false

func _ready() -> void:
	if coin: $Coin.show()
func _physics_process(delta: float) -> void:
	if !move: return
	global_position.x += speed * delta * direction
	if global_position.x < 58.0:
		direction = 1
	if global_position.x > 266.0:
		direction = -1


func _screen_exited() -> void:
	queue_free()

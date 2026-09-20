extends Node2D

@onready var pool = [
	preload("res://tiles/tile/tile.tscn"),
	preload("res://tiles/destroyable_tile/destroyable_tile.tscn"),
	preload("res://tiles/tile/jump_pad_tile.tscn"),
]
var t: float = 0
var height: float = 536.0
func _process(delta: float) -> void:
	t += delta
	if t > 1.0:
		t = 0.0
		height -= 100
		var inst =pool.pick_random().instantiate()
		inst.global_position = Vector2(randf_range(58, 266), height)
		$Tiles.add_child(inst)

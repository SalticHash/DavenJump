extends Node2D

@onready var pool = [
	preload("res://tiles/tile/tile.tscn"),
	preload("res://tiles/destroyable_tile/destroyable_tile.tscn"),
	preload("res://tiles/tile/jump_pad_tile.tscn"),
]
var t: float = 0
var height: float = 536.0
var height_int = 150.0
var move_chance: float = 0.25
var speed_mul: float = 1.0
func _process(delta: float) -> void:
	t += delta
	if height > $Player.global_position.y - 288 - height_int * 2:
		t = 0.0
		height -= height_int
		if height_int == 2000: height_int = 150.0
		var i = 0
		if randf() < move_chance: i = 1
		if randf() < 0.1: i = 2
		var inst = pool[i].instantiate()
		if i == 1: inst.randomize_health(move_chance)
		if randf() < 0.75:
			inst.coin = true
		if randf() < move_chance:
			inst.direction = -1 if randi_range(0,1) == 0 else 1
			inst.speed = randf_range(32, 128) * speed_mul
			inst.move = true 
			speed_mul += 0.05
		move_chance = min(move_chance + 0.008, 0.8)
		if inst.name == "JumpPadTile": height_int = 2000
		inst.global_position = Vector2(randf_range(58, 266), height)
		$Tiles.add_child(inst)

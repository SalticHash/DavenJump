extends Node

var last_coins: int = -1
var touch: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey: touch = false
	if event is InputEventScreenTouch: touch = true

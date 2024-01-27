extends Node2D

var is_stuck := false
var prev_pos := Vector2.ZERO

func _ready():
	pass

func _process(_delta):
	pass

func drop(dir: Vector2):
	prev_pos = position
	if !is_stuck:
		position += dir

func _on_area_2d_area_entered(_area):
	if !is_stuck:
		if position.y > prev_pos.y:
			is_stuck = true
			GameManager.update_grid(prev_pos)
		position = prev_pos

extends Node2D
class_name  BlockClass

var is_stuck := false
var prev_pos := Vector2.ZERO

func move(dir: Vector2):
	if is_stuck: return
	position += dir

func drop():
	if !is_stuck:
		if GameManager.collision_check(position):
			_stick_all()
			#is_stuck = true
			GameManager.grid.check_lines()
			return
		position.y += 8

func _stick_all():
	for block in get_tree().get_nodes_in_group("Block"):
		block.is_stuck = true

extends Node2D
class_name  BlockClass

var is_stuck := false
var prev_pos := Vector2.ZERO

func move(dir: Vector2):
	if is_stuck: return
	position += dir

func drop(dir := Vector2.DOWN):
	if !is_stuck:
		position += dir * GameManager.cell_size

func stick():
	is_stuck = true


		#if GameManager.collision_check(position):
			#_stick_all()
			##is_stuck = true
			#GameManager.grid.check_lines()
			#return
		#position.y += 8
#
#func _stick_all():
	#for block in get_tree().get_nodes_in_group("Block"):
		#block.is_stuck = true

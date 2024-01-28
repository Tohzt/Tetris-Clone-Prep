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
			is_stuck = true
			GameManager.check_lines()
			return
		position.y += 8
		#prev_pos = position
		#position += dir
		
# TODO: Replace with collision prediction
# If collision is found, tell all other falling blocks to get stuck
func _on_area_2d_area_entered(_area):
	return
	position = prev_pos
	is_stuck = true
	GameManager.check_lines()

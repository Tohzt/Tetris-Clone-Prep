extends Node2D
class_name  BlockClass

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

# TODO: Replace with collision prediction
# If collision is found, tell all other falling blocks to get stuck
func _on_area_2d_area_entered(_area):
	position = prev_pos
	is_stuck = true
	GameManager.check_lanes()
	#if !is_stuck:
		#if position.y > prev_pos.y:
			#is_stuck = true
		#position = prev_pos

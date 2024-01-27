extends Node

var grid_scene: Node2D

var game_is_paused := false
var grid_width := 10
var grid_height := 10
var cell_size := 32

func _ready():
	print()
	pass

func _process(_delta):
	if grid_scene:
		print(grid_scene)
	pass

func drop_blocks():
	pass

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
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("DOWN"):
		drop_blocks()

func drop_blocks():
	var blocks = get_tree().get_nodes_in_group("Block")
	for block in blocks:
		block.drop()

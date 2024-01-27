extends Node

var grid_scene: Node2D

var game_is_paused := false
var grid_width := 10
var grid_height := 10
var cell_size := 8

func _ready():
	print()
	pass

func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("DOWN"):
		drop_blocks(Vector2.DOWN)
	if Input.is_action_just_pressed("LEFT"):
		drop_blocks(Vector2.LEFT)
	if Input.is_action_just_pressed("RIGHT"):
		drop_blocks(Vector2.RIGHT)

func drop_blocks(dir: Vector2):
	var blocks = get_tree().get_nodes_in_group("Block")
	for block in blocks:
		block.drop(dir * cell_size)

func update_grid(pos):
	print(pos / cell_size)

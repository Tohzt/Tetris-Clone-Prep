extends Node

var grid_scene: Node2D

var game_is_paused := false
var grid_width := 10
var grid_height := 20
var cell_size := 8
var grid_data : Array

func _ready():
	_clear_grid()

func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("LEFT"):
		drop_blocks(Vector2.LEFT)
	if Input.is_action_just_pressed("RIGHT"):
		drop_blocks(Vector2.RIGHT)

func drop_blocks(dir: Vector2):
	var blocks = get_tree().get_nodes_in_group("Block")
	for block in blocks:
		block.drop(dir * cell_size)

func update_grid():
	_clear_grid()
	for block: BlockClass in get_tree().get_nodes_in_group("Block"):
		var block_pos = block.prev_pos / cell_size
		if block.is_stuck:
			grid_data[block_pos.y][block_pos.x] = 1
		else:
			grid_data[block_pos.y][block_pos.x] = -1
	_print_grid()

func check_lanes():
	update_grid()
	var lanes = []
	for row in grid_height:
		var row_count = 0
		for col in grid_width:
			if grid_data[row][col] > 0:
				row_count += 1
		if row_count == grid_width:
			lanes.append(row)
	_clear_lanes(lanes)

func _clear_lanes(lanes: Array) -> void:
	if !lanes: return
	
	for block in get_tree().get_nodes_in_group("Block"):
		if block.position.y / cell_size == lanes[0]:
			block.queue_free()
	
	update_grid()

func _clear_grid():
	grid_data = []
	for col in grid_height:
		var grid_row := []
		for row in grid_width:
			grid_row.append(0)
		grid_data.append(grid_row)

func _print_grid():
	print("==============================")
	for row in grid_height:
		print(grid_data[row])

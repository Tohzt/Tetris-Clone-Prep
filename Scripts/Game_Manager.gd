extends Node

var grid:Grid

var game_is_paused := false

func _unhandled_input(_event):
	if Input.is_action_just_pressed("LEFT"):
		_move_blocks(Vector2.LEFT)
	if Input.is_action_just_pressed("RIGHT"):
		_move_blocks(Vector2.RIGHT)

# TODO: Combine move and drop
# move if parameter exists
func _move_blocks(dir: Vector2):
	var blocks = get_tree().get_nodes_in_group("Block")
	for block in blocks:
		block.move(dir * grid.cell_size)

func drop_blocks():
	var blocks = get_tree().get_nodes_in_group("Block")
	for block in blocks:
		block.drop()

func collision_check(pos) -> bool:
	var grid_pos = Vector2(pos.x/grid.cell_size, pos.y/grid.cell_size +1)
	if grid_pos.y == grid.height:
		return true
	if grid.data[grid_pos.y][grid_pos.x] > 0:
		return true
	return false

func _process(_delta):
	#print_grid()
	pass

func print_grid():
	print("===============================")
	if grid:
		for col in grid.height:
			var grid_row = []
			for row in grid.width:
				grid_row.append(grid.data[col][row])
			print(grid_row)

extends Node

@onready var blocks = preload("res://Scenes/Block_Scene.tscn")

var game_is_paused := false
var cell_size := 8
var grid : Grid

var drop_cd = 0
var drop_cd_dur = 0.25#1

var seven_bag := []

func _ready():
	_fill_bag()

func _fill_bag():
	seven_bag = ["I", "J", "L", "O", "S", "T", "Z"]
	seven_bag.shuffle()

func _process(delta):
	if grid: 
		if drop_cd > 0:
			drop_cd -= delta
		else:
			drop_cd = drop_cd_dur
			drop_blocks()
			grid.update_grid( )

# TODO: Should I move this?
func _unhandled_input(_event):
	if grid:
		if Input.is_action_just_pressed("LEFT"):
			drop_blocks(Vector2.LEFT)
		if Input.is_action_just_pressed("RIGHT"):
			drop_blocks(Vector2.RIGHT)
		if Input.is_action_just_pressed("SPACE"):
			_spawn_tetromino()

func _spawn_tetromino() -> void:
	drop_cd = drop_cd_dur
	if seven_bag.size() == 0:
		_fill_bag()
	var tetromino = Tetrominos.Shape[seven_bag.pop_back()]
	#print(tetromino)
	for col in tetromino.size():
		for row in tetromino[col].size():
			if tetromino[col][row] == 1:
				var offset = Vector2(row * cell_size, col * cell_size)
				var block = blocks.instantiate()
				block.position.x += grid.offset
				block.position += offset
				grid.blocks.add_child(block)


# TODO: Combine move and drop
# move if parameter exists
func _move_blocks(dir: Vector2):
	var blocks_in_grid = get_tree().get_nodes_in_group("Block")
	for block in blocks_in_grid:
		block.move(dir * cell_size)

func drop_blocks(dir := Vector2.DOWN):
	var can_drop = true
	var blocks_inGrid = get_tree().get_nodes_in_group("Block")
	for block:BlockClass in blocks_inGrid:
		var block_posInGrid = block.position / GameManager.cell_size
		block_posInGrid += dir
		
		if block.is_stuck == false:
			if block_posInGrid.y == grid.height \
			or block_posInGrid.x < 0 or block_posInGrid.x == grid.width\
			or grid.data[block_posInGrid.y][block_posInGrid.x] > 0:
				can_drop = false
	
	if can_drop:
		for block in blocks_inGrid:
			block.drop(dir)
		return
	
	if dir == Vector2.DOWN:
		for block in blocks_inGrid:
			block.stick()
		grid.check_lines()

func collision_check(pos) -> bool:
	var grid_pos = Vector2(pos.x/cell_size, pos.y/cell_size +1)
	if grid_pos.y == grid.height:
		return true
	if grid.data[grid_pos.y][grid_pos.x] > 0:
		return true
	return false


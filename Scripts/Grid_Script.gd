class_name  Grid
extends Node2D

@onready var blocks = preload("res://Scenes/Block_Scene.tscn")

var data : Array
var width := 10.0
var height := 20
var cell_size := 8
var grid_offset = width/2 * cell_size

func _ready():
	GameManager.grid = self
	_clear_grid()
	$Timer.start()

func _unhandled_input(event):
	if Input.is_action_just_pressed("SPACE"):
		_spawn_tetromino()

func _spawn_tetromino() -> void:
	var tetromino = Tetrominos.Shape["T"]
	print(tetromino)
	for col in tetromino.size():
		for row in tetromino[col].size():
			if tetromino[col][row] == 1:
				var offset = Vector2(row * cell_size, col * cell_size)
				var block = blocks.instantiate()
				block.position.x += grid_offset
				block.position += offset
				$Blocks.add_child(block)

func _drop_blocks():
	GameManager.drop_blocks()
	update_grid( )

func update_grid():
	_clear_grid()
	for block: BlockClass in get_tree().get_nodes_in_group("Block"):
		var block_pos = block.position / cell_size
		if block.is_stuck:
			data[block_pos.y][block_pos.x] = 1
		else:
			data[block_pos.y][block_pos.x] = -1

func check_lines():
	update_grid()
	var lanes = []
	for row in height:
		var row_count = 0
		for col in width:
			if data[row][col] > 0:
				row_count += 1
		if row_count == width:
			lanes.append(row)
	_clear_lines(lanes)

func _clear_lines(lanes: Array) -> void:
	if !lanes: return
	for block in get_tree().get_nodes_in_group("Block"):
		if block.position.y / cell_size == lanes[0]:
			block.queue_free()
	update_grid()

func _clear_grid():
	data = []
	for col in height:
		var _row := []
		for row in width:
			_row.append(0)
		data.append(_row)

class_name  Grid
extends Node2D

@onready var blocks = $Blocks

var data : Array
var width := 10.0
var height := 20
var offset = width/2 * GameManager.cell_size

func _ready():
	GameManager.grid = self
	_clear_grid()

func update_grid():
	_clear_grid()
	for block: BlockClass in get_tree().get_nodes_in_group("Block"):
		var block_posInGrid = block.position / GameManager.cell_size
		if block.is_stuck:
			data[block_posInGrid.y][block_posInGrid.x] = 1
		else:
			data[block_posInGrid.y][block_posInGrid.x] = -1

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
		for lane in lanes.size():
			if block.position.y / GameManager.cell_size == lanes[lane]:
				block.queue_free()
	update_grid()

func _clear_grid():
	data = []
	for col in height:
		var _row := []
		for row in width:
			_row.append(0)
		data.append(_row)





#func _process(_delta):
	#print_grid()
	#pass
#
#func print_grid():
	#print("===============================")
	#for col in height:
		#var grid_row = []
		#for row in width:
			#grid_row.append(data[col][row])
		#print(grid_row)

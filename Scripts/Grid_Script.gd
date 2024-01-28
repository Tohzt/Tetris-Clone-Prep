extends Node2D

@onready var blocks = preload("res://Scenes/Block_Scene.tscn")
@onready var offset = position

func _ready():
	$Timer.start()
	GameManager.grid_scene = self

func _unhandled_input(_event):
	if Input.is_action_just_pressed("SPACE"):
		var block = blocks.instantiate()
		$Blocks.add_child(block)

func _drop_blocks():
	GameManager.drop_blocks()
	GameManager.update_grid( )

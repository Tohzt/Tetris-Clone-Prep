extends Node2D

@onready var blocks = preload("res://Scenes/Block_Scene.tscn")
@onready var offset = position

func _ready():
	GameManager.grid_scene = self
	
func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("START"):
		var block = blocks.instantiate()
		$Blocks.add_child(block)

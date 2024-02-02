extends Node2D

@onready var pause_screen = $CenterContainer/PauseScreen
const menu_scene = "res://Scenes/Menu_Scene.tscn"

func _ready():
	pause_screen.visible = false

func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("START"):
		_pause_game()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file(menu_scene)

func _pause_game() -> void:
	GameManager.game_is_paused = !GameManager.game_is_paused
	pause_screen.visible = GameManager.game_is_paused

extends CanvasLayer

const game_scene = "res://Scenes/Game_Scene.tscn"

func _unhandled_input(_event):
	if Input.is_action_just_pressed("START"):
		if $CenterContainer/Intro.visible:
			$CenterContainer/Intro.visible = false
		else:
			get_tree().change_scene_to_file(game_scene)

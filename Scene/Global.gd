extends Node2D

func _process(delta):
	pass

func _on_tile_map_game_over():
	$Camera2D/Control.visible = true
	$Camera2D/Control/Label3.text = str($Camera2D/Label.score)

func _on_exit_button_up():
	get_tree().quit()

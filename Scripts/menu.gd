extends Node2D



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _ready() -> void:
	
	# Ajusta la posición de la ventana en la pantalla
	DisplayServer.window_set_position(Vector2(450, 50)) 
	$music/MenuMusic.play()

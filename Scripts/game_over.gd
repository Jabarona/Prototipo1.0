extends Node2D

@onready var button = $Button  # Asegúrate de que el nombre coincida con el nodo de tu botón
@onready var label = $Label    # Asegúrate de que el nombre coincida con el nodo de tu etiqueta de texto
@onready var retry_button = $Retry_button  # Botón para intentar de nuevo si no se alcanzan 1000 puntos

var code_generated = false  # Variable para verificar si el código ya ha sido generado

# Esta función se llama cuando la escena está lista
func _ready() -> void:
	# Ajusta el tamaño de la ventana
	DisplayServer.window_set_size(Vector2(1152, 642))
	DisplayServer.window_set_position(Vector2(450, 50))


	
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	retry_button.connect("pressed", Callable(self, "_on_retry_button_pressed"))

	# Asegúrate de que el texto esté oculto al principio
	label.visible = false

	# Verificar el puntaje y mostrar el botón correspondiente
	if Global.puntos >= 500:
		button.visible = true  # Mostrar el botón de código si tiene 1000 o más puntos
		retry_button.visible = false  # Ocultar el botón de intentar de nuevo
	else:
		retry_button.visible = true  # Mostrar el botón para intentar de nuevo si no tiene 1000 puntos
		button.visible = false  # Ocultar el botón de código

func _on_button_pressed() -> void:
	if not code_generated:
		# Genera un texto de 7 dígitos
		var text = str(randi_range(1000000, 9999999))
		label.text = text
		label.visible = true

		# Marca que el código ha sido generado
		code_generated = true

		# Desactiva el botón para que no se pueda presionar de nuevo
		button.disabled = true

		# Inicia un temporizador para volver al menú después de 15 segundos
		var timer = Timer.new()
		timer.wait_time = 5
		timer.one_shot = true
		timer.connect("timeout", Callable(self, "_on_timer_timeout"))
		add_child(timer)
		timer.start()

func _on_timer_timeout() -> void:
	Global.reset_game() 
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_retry_button_pressed() -> void:
	Global.reset_game()  # Reiniciar puntaje y energía
	get_tree().change_scene_to_file("res://scenes/main.tscn")

extends Node2D

var pre_enemyShip = preload("res://scenes/EnemyShip.tscn")
var pre_asteroid = preload("res://scenes/asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Cambia el tamaño de la ventana a 2796x1290
	DisplayServer.window_set_size(Vector2(430, 932))
		# Ajusta la posición de la ventana en la pantalla
	DisplayServer.window_set_position(Vector2(650, 50))
	
	$music/mainMusic.play()
	
	# Aquí puedes agregar el código que ya tenías
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	randomize()
	var randomEnemy = round(randf_range(1, 2))
	
	if randomEnemy == 1:
		var enemyShip = pre_enemyShip.instantiate()
		self.call_deferred("add_child", enemyShip)
		enemyShip.position.x = round(randf_range(100, 200))
		enemyShip.add_to_group("enemyShip")
		
	if randomEnemy == 2:
		var asteroid = pre_asteroid.instantiate()
		self.call_deferred("add_child", asteroid)
		asteroid.position.x = round(randf_range(100, 200))
		asteroid.add_to_group("enemyShip")
		

func _physics_process(_delta):
	$hud/Dpoints.text = str(Global.energia)
	$hud/points.text= str(Global.puntos)

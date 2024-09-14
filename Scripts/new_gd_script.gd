extends CharacterBody2D

var move_speed = 400

var screen_size = Vector2(430, 932)  # Tamaño de la pantalla (iPhone 15 Pro Max)

# Tamaño del personaje, ajustar según el tamaño real
var character_size = Vector2(64, 64)  # Ajusta según el tamaño real de la nave

# Declarar pre_bullet como una variable de instancia
@export var pre_bullet: PackedScene

var readytoShoot = true

func _ready():
	# Inicializa pre_bullet al cargar el juego
	pre_bullet = preload("res://scenes/bullet.tscn")

func _physics_process(_delta):
	# Inicializa la velocidad
	self.velocity = Vector2.ZERO

	# Detecta la entrada del usuario y ajusta la velocidad
	if Input.is_action_pressed("d"):
		self.velocity.x = move_speed
	if Input.is_action_pressed("a"):
		self.velocity.x = -move_speed
	if Input.is_action_pressed("w"):
		self.velocity.y = -move_speed
	if Input.is_action_pressed("s"):
		self.velocity.y = move_speed
	if Input.is_action_pressed("f"):
		shoot()

	# Mueve el personaje usando move_and_slide() sin argumentos
	move_and_slide()

	# Restringe la posición de la nave dentro de los márgenes considerando el tamaño del personaje
	position.x = clamp(position.x, character_size.x / 2, screen_size.x - character_size.x / 2)
	position.y = clamp(position.y, character_size.y / 2, screen_size.y - character_size.y / 2)

func shoot():
	if readytoShoot:
		var bullet = pre_bullet.instantiate()
		get_parent().call_deferred("add_child", bullet)
		bullet.position = self.position + Vector2(-3, -35)
		readytoShoot = false
		# Espera 1 segundo antes de permitir otro disparo
		await get_tree().create_timer(.30).timeout
		readytoShoot = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		print("asteroid crash")
	elif area.is_in_group("enemyShip"):
		print("enemyShip crash")

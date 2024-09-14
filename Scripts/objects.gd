extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		Global.puntos +=10
		Global.playSound("enemyImpact")
		queue_free()
	if area.is_in_group("player"):
		queue_free()
		
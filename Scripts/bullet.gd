extends CharacterBody2D


func _physics_process(_delta):
	position.y -=10
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()
	

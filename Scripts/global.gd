extends Node

var puntos = 0
var energia = 100

func reset_game():
	puntos = 0
	energia= 100

func playSound(sound):
	if sound == "enemyImpact":
		get_node("/root/main/sounds/enemyImpact").play()

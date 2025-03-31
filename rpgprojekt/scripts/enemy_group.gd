extends Node2D

var enemies: Array

func _ready():
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position = Vector2(0, i*40)
		enemies[i].add_to_group("enemies")
		enemies[i].add_to_group("combatants")

func get_entities():
	return enemies

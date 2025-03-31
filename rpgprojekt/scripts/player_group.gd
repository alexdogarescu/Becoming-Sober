extends Node2D

var party: Array

func _ready():
	party = get_children()
	for i in party.size():
		party[i].position = Vector2(0, 40*i)
		party[i].add_to_group("players")
		party[i].add_to_group("combatants")
		
func get_entities():
	return party

extends Node2D

var active_party: Array = []  # Stores current party members (PlayerCharacter nodes)

func add_to_party(character: Character):
	active_party.append(character)
	character.add_to_group("players")
	character.add_to_group("combatants")
	print(character.name + " joined the party!")

func remove_from_party(character: Character):
	if character in active_party:
		active_party.erase(character)
		character.remove_from_group("players")
		character.remove_from_group("combatants")
		print(character.name + " left the party!")

func get_party():
	return active_party

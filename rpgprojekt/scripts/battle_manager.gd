extends Node2D

var turn_order = []
var current_turn_index = 0

func _ready():
	setup_battle()

func setup_battle():
	turn_order.clear()
	var party = get_tree().get_nodes_in_group("players")
	var enemies = get_tree().get_nodes_in_group("enemies")
	turn_order.append_array(party + enemies)  # Combine both groups
	turn_order.sort_custom(func(a, b): return a.attack > b.attack)  # Sort by speed
	current_turn_index = 0
	next_turn()

func next_turn():
	if turn_order.is_empty():
		return
	
	if current_turn_index >= turn_order.size():
		current_turn_index = 0

	var current_combatant = turn_order[current_turn_index]
	
	if current_combatant is PlayerCharacter:
		start_player_turn(current_combatant)
	else:
		start_enemy_turn(current_combatant)
		
func start_player_turn(player: Character):
	print(player.name + "'s turn! Choose an action.")

func start_enemy_turn(enemy: Character):
	print(enemy.name + "'s turn!")
	
	var target = pick_random_target(get_tree().get_nodes_in_group("players"))
	
	if target:
		enemy.attack_target(target)
	
	next_turn()

func pick_random_target(targets):
	if targets.is_empty():
		return null
	return targets[randi() % targets.size()]

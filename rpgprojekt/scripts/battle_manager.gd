extends Node2D

var turn_order = []
var current_turn_index = 0
var current_combatant
@onready var attack_button = $attack
var party
var enemies
func _ready():
	setup_battle()

func setup_battle():
	turn_order.clear()
	party = get_tree().get_nodes_in_group("players")
	enemies = get_tree().get_nodes_in_group("enemies")
	turn_order.append_array(party + enemies)  # Combine both groups
	#turn_order.sort_custom(func(a, b): return a.stats.speed > b.stats.speed)  # Sort by speed
	current_turn_index = 0
	next_turn()

func next_turn():
	if enemies.is_empty():
		get_tree().change_scene_to_file("res://scenes/world.tscn")
	elif party.is_empty():
		get_tree().change_scene_to_file("res://scenes/player_character.tscn")
	attack_button.visible = false
	
	current_turn_index += 1
	
	if turn_order.is_empty():
		return
	
	if current_turn_index >= turn_order.size():
		current_turn_index = 0

	current_combatant = turn_order[current_turn_index]
	
	if current_combatant is PlayerCharacter:
		start_player_turn(current_combatant)
	else:
		start_enemy_turn(current_combatant)
		
		
func start_player_turn(player: Character):
	print(player.name + "'s turn! Choose an action.")
	attack_button.visible = true
	
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


func _on_attack_pressed():
	current_combatant.attack_target(pick_random_target(get_tree().get_nodes_in_group("enemies")))
	attack_button.visible = false
	next_turn()

@onready var healthbar = $"../enemy_party/enemy/TextEdit"

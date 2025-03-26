extends Node2D

var turn_order = []
var current_turn_index = 0
var current_combatant
@onready var attack_button = $UI/player_ui/attack
@onready var skills_menu = $UI/player_ui/skills
@onready var player_ui = $UI/player_ui
var party
var enemies
func _ready():
	setup_battle()

func setup_battle():
	turn_order.clear()
	party = PartyManager.active_party
	enemies = get_tree().get_nodes_in_group("enemies")
	turn_order.append_array(party + enemies)  # Combine both groups
	turn_order.sort_custom(func(a, b): return a.attack > b.attack)  # Sort by speed
	current_turn_index = 0
	next_turn()

func next_turn():
	turn_order = turn_order.filter(func(obj): return is_instance_valid(obj))
	enemies = enemies.filter(func(obj): return is_instance_valid(obj))
	party = party.filter(func(obj): return is_instance_valid(obj))
	
	if enemies.is_empty():
		get_tree().change_scene_to_file("res://scenes/world.tscn")
	elif party.is_empty():
		get_tree().change_scene_to_file("res://scenes/player_character.tscn")
	player_ui.visible = false
	
	current_turn_index += 1
	
	if current_turn_index >= turn_order.size():
		current_turn_index = 0
	
	if turn_order.is_empty():
		return
	
	current_combatant = turn_order[current_turn_index]
	
	if current_combatant is PlayerCharacter:
		await start_player_turn(current_combatant)
	else:
		await start_enemy_turn(current_combatant)
		
		
func start_player_turn(player: Character):
	print(player.name + "'s turn! Choose an action.")
	player_ui.visible = true
	
func start_enemy_turn(enemy: Character):
	print(enemy.name + "'s turn!")
	var target = pick_random_target(get_tree().get_nodes_in_group("players"))
	if target:
		await enemy.attack_target(target)
	next_turn()

func pick_random_target(targets):
	if targets.is_empty():
		return null
	return targets[randi() % targets.size()]


func _on_attack_pressed():
	player_ui.visible = false
	await current_combatant.attack_target(pick_random_target(get_tree().get_nodes_in_group("enemies")))
	next_turn()

@onready var healthbar = $"../enemy_party/enemy/TextEdit"

func _on_skills_about_to_popup():
	skills_menu.add_skills_on_popup(current_combatant.get_skills())

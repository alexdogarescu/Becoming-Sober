extends Node2D

var turn_order = []
var current_turn_index = 0
var current_combatant
var player_turn = false
@onready var attack_button = $"../UI/button_container/attack"
@onready var items_button = $"../UI/button_container/items"
@onready var skills_button = $"../UI/button_container/skills"
@onready var skills_menu = $"../UI/button_container/skills/skills_menu"
@onready var index: int = 0 #this is for enemies
@onready var index_p: int = 0 #this is for players and will be used for support skills
#@onready var party_manager = $"../party_manager"

var party
var enemies
var battle_over = false


func _ready():
	setup_battle()

func setup_battle():
	turn_order.clear()
	#party = party_manager.get_party()
	#party = $"../player_group".get_entities()
	party = get_tree().get_nodes_in_group("players")
	#enemies = $"../enemy_group".get_entities()
	enemies = get_tree().get_nodes_in_group("enemies")
	turn_order.append_array(party + enemies)  # Combine both groups
	#turn_order.sort_custom(func(a, b): return a.stats.speed > b.stats.speed)  # Sort by speed
	current_turn_index = 0
	next_turn()

func next_turn():
	disable_buttons()
	
	turn_order = turn_order.filter(func(obj): return is_instance_valid(obj))
	party = party.filter(func(obj): return is_instance_valid(obj))
	enemies = enemies.filter(func(obj): return is_instance_valid(obj))
	
	if enemies.is_empty():
		
		#get_tree().change_scene_to_file("res://scenes/world.tscn")
		battle_over = true
	elif party.is_empty():
		#get_tree().change_scene_to_file("res://scenes/world.tscn")
		battle_over = true
	#here we get rid of null elements of our arrays
	
	current_turn_index += 1
	
	print("Turn " + str(current_turn_index) + " started...")
	
	if turn_order.is_empty():
		print("There are no combatants..")
		return
	
	if current_turn_index >= turn_order.size():
		current_turn_index = 0

	current_combatant = turn_order[current_turn_index]
	
	if current_combatant is PlayerCharacter:
		start_player_turn(current_combatant)
	else:
		start_enemy_turn(current_combatant)
		
		
func start_player_turn(player: Character):
	if not battle_over:
		player_turn = true
	print(player.name + "'s turn! Choose an action.")
	enable_buttons()

func _process(_delta):
	if battle_over:
		get_tree().change_scene_to_file("res://scenes/world.tscn")
	if player_turn:
		if enemies[index] != null:
			enemies[index].focus()
		if Input.is_action_just_pressed("ui_up"):
			if index > 0:
				index -= 1
				switch_focus(index+1, index)
		if Input.is_action_just_pressed("ui_down"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index-1, index)

func switch_focus(x, y):
	if enemies[x] != null:
		enemies[x].unfocus()
	if enemies[y] != null:
		enemies[y].focus()

	
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
	player_turn = false
	disable_buttons()
	enemies[index].unfocus()
	current_combatant.attack_target(enemies[index])
	next_turn()


func disable_buttons():
	attack_button.disabled = true
	skills_button.disabled = true
	items_button.disabled = true
	
func enable_buttons():
	attack_button.disabled = false
	skills_button.disabled = false
	items_button.disabled = false

func _on_skills_pressed():
	skills_menu.get_popup().add_item(current_combatant.stats.get_skills())

func _on_items_pressed():
	pass # Replace with function body.

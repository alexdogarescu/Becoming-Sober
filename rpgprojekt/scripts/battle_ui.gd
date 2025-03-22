extends Control

@onready var skill_panel = $skill_panel
@onready var target_panel = $target_panel

var selected_skill = null  # Stores the chosen skill
var current_combatant = null  # Stores the active character

func show_skill_selection(combatant):
	# Displays skills when a player character's turn starts
	if not combatant is PlayerCharacter:
		return  # Only players choose skills

	current_combatant = combatant
	skill_panel.visible = true
	skill_panel.clear()  # Remove old skill buttons

	for skill in combatant.get_skills():
		var button = Button.new()
		button.text = skill.name
		button.pressed.connect(func(): on_skill_selected(skill))
		skill_panel.add_child(button)

func on_skill_selected(skill):
	# Called when a player selects a skill
	selected_skill = skill
	skill_panel.visible = false
	show_target_selection()  # Move to the next step

func show_target_selection():
	# Shows the target selection panel after choosing a skill
	target_panel.visible = true
	target_panel.clear()  # Remove old target buttons

	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		var button = Button.new()
		button.text = enemy.name
		button.pressed.connect(func(): on_target_selected(enemy))
		target_panel.add_child(button)

func on_target_selected(target):
	# Executes the selected skill on the chosen target
	target_panel.visible = false
	if current_combatant and selected_skill:
		current_combatant.use_skill(selected_skill, target)
		get_node("/root/BattleManager").next_turn()  # Move to next combatant

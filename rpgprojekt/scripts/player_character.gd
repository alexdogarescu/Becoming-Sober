class_name PlayerCharacter extends Character
#const BattleManager = preload("res://scripts/battle_manager.gd")
var skills = [
	{"name": "Stab", "damage": 20, "sp_cost": 5},
	{"name": "Drink", "damage": -10, "sp_cost": 10}, #negative damage is healing
	{"name": "Piss", "damage": 999, "sp_cost": -20} 
] 
#interesting way to basically create your own variable types.
#the game will interpret each line as its own seperate entity
#we can add skills by basically using add_skill(Fireball, 35, 10) as an example
#using the script that I made

func attack_target(target: Character):
	print(name + " attacks " + target.name)
	self.position += Vector2(-10, 0)
	await get_tree().create_timer(0.5).timeout
	await target.take_damage(attack)
	await get_tree().create_timer(0.5).timeout
	self.position += Vector2(10, 0)
	#BattleManager.next_turn()
	
func get_skills():
	return skills
	
func add_skill(skill_name, skill_damage, skill_sp_cost):
	skills.append({"name": skill_name, "damage": skill_damage, "sp_cost": skill_sp_cost})

func use_skill(skill, target):
	# Uses the selected skill on a target 
	if "sp_cost" in skill and skill.sp_cost > 0:
		if sp < skill.sp_cost:
			print(name + " does not have enough MP!")
			return
		sp -= skill.sp_cost  # Reduce MP for skill usage

	# Apply skill effect
	if skill.damage >= 0:
		print(name + " uses " + skill.name + " on " + target.name + "!")
		target.take_damage(skill.damage)
	else:
		print(name + " casts " + skill.name + " and heals " + target.name + "!")
		target.heal(-skill.damage)
	

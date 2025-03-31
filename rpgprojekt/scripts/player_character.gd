class_name PlayerCharacter extends Character
#const BattleManager = preload("res://scripts/battle_manager.gd")


func attack_target(target: Character):
	print(name + " attacks " + target.name)
	target.take_damage(stats.attack)
	#BattleManager.next_turn()
	
func get_skills():
	return stats.skills
	
func add_skill(skill_name, skill_damage, skill_sp_cost):
	stats.skills.append({"name": skill_name, "damage": skill_damage, "sp_cost": skill_sp_cost})

func use_skill(skill, target):
	# Uses the selected skill on a target 
	if "mp_cost" in skill and skill.mp_cost > 0:
		if stats.sp < skill.sp_cost:
			print(name + " does not have enough MP!")
			return
		stats.sp -= skill.sp_cost  # Reduce MP for skill usage

	# Apply skill effect
	if skill.damage >= 0:
		print(name + " uses " + skill.name + " on " + target.name + "!")
		target.take_damage(skill.damage)
	else:
		print(name + " casts " + skill.name + " and heals " + target.name + "!")
		target.heal(-skill.damage)
	

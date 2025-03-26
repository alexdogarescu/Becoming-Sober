class_name Enemy extends Character
func attack_target(target: Character):
	print(name + " attacks " + target.name)
	await get_tree().create_timer(0.5).timeout
	self.position += Vector2(10, 0)
	await get_tree().create_timer(0.5).timeout
	target.take_damage(attack)
	await get_tree().create_timer(0.5).timeout
	self.position += Vector2(-10, 0)

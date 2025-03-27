class_name Enemy extends Character
func attack_target(target: Character):
	print(name + " attacks " + target.name)
	self.move_local_x(5)
	wait_with_timer(2)
	target.take_damage(attack)
	self.move_local_x(-5)

extends Character

class_name EnemyCharacter

func _onready():
	$Sprite2D.texture = stats.texture
	
func attack_target(target: Character):
	target.take_damage(self.stats.attack)
	

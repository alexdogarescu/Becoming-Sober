extends Resource

class_name Character_Stats


@export var speed: int
@export var max_hp: int
@export var attack: int
@export var max_sp: int
@export var defence: int
@export var skills: Array

func get_skills():
	return skills

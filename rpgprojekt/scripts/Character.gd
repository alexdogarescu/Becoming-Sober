extends Node

class_name Character

@export var max_hp: int
@export var character_name: String
@export var attack: int
@export var defense: int
@export var max_sp: int
@export var speed: int

@export var current_hp: int
@export var current_sp: int

func _ready():
	current_hp = max_hp
	current_sp = max_sp

func take_damage(damage: int):
	current_hp -= damage-defense
	if current_hp <= 0:
		die()
		#give condition for give in only for player character
	
func die():
	#exit queue
	pass

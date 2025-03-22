extends Node2D

class_name Character

@export var max_hp: int
@export var character_name: String
@export var attack: int
@export var defense: int
@export var max_sp: int
@export var speed: int

@export var hp: int
@export var sp: int

func _ready():
	hp = max_hp
	sp = max_sp
	
	add_to_group("combatants")
	if self is PlayerCharacter:
		add_to_group("players")
	elif self is Enemy:
		add_to_group("enemies")

func take_damage(damage: int):
	hp -= damage-defense/4
	if hp <= 0:
		die()
		# Give condition for give in only for player character

func heal(heal: int):
	if hp+heal > max_hp:
		hp = max_hp
	else:
		hp += heal
	
func die():
	#exit queue
	pass

@onready var my_timer = $Timer  # Reference to the Timer node

func wait_with_timer(amount: int):
	print("Starting timer...")
	my_timer.start(amount) # IN SECONDS, NOT MILISECONDS. DON'T GIVE ABSURD VALUES
	await my_timer.timeout
# This is for certain animations, so we don't need to create a new timer everytime

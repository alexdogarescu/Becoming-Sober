extends Node2D

class_name Character
@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
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
	#speed = $stats.get_meta("speed", 5)
	#HOW THE FUCK CAN I STORE STATS FOR DIFFERENT CHARACTERS?!?!?!!
	#METADATA _MUST_ BE UNIQUE????!!
	add_to_group("combatants")
	if self is PlayerCharacter:
		add_to_group("players")
	elif self is Enemy:
		add_to_group("enemies")

func take_damage(damage: int):
	hp -= damage-defense/4
	animation_player.play("hurt")
	print(str(damage) + " damage has been taken by " + name)
	_update_hp_bar()
	if hp <= 0:
		die()
		# Give condition for give in only for player character

func heal(heal: int):
	if hp+heal > max_hp:
		hp = max_hp
	else:
		hp += heal
	_update_hp_bar()
	
func die():
	queue_free()

@onready var my_timer = $Timer  # Reference to the Timer node

func wait_with_timer(amount: int):
	print("Starting timer...")
	my_timer.start(amount) # IN SECONDS, NOT MILISECONDS. DON'T GIVE ABSURD VALUES
	await my_timer.timeout
# This is for certain animations, so we don't need to create a new timer everytime

func _update_hp_bar():
	progress_bar.value = (hp/max_hp) * 100

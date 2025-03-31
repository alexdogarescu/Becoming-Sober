extends Node2D

class_name Character
@onready var animation_player = $AnimationPlayer
@export var stats: Resource
@export var hp: int
@export var sp: int


func _ready():
	#speed = $stats.get_meta("speed", 5)
	#HOW THE FUCK CAN I STORE STATS FOR DIFFERENT CHARACTERS?!?!?!!
	#METADATA _MUST_ BE UNIQUE????!!
	hp = stats.max_hp
	sp = stats.max_sp
	add_to_group("combatants")
	if self is PlayerCharacter:
		add_to_group("players")
		stats = Character_Stats
	elif self is EnemyCharacter:
		add_to_group("enemies")
		stats = Enemy_Stats

func take_damage(damage: int):
	hp -= damage-stats.defence/4
	animation_player.play("hurt")
	print(str(damage) + " damage has been taken by " + name)
	if hp <= 0:
		die()
		# Give condition for give in only for player character

func heal(heal: int):
	if hp+heal > stats.max_hp:
		hp = stats.max_hp
	else:
		hp += heal

func die():
	queue_free()
	
func focus():
	$focus.show()
	
func unfocus():
	$focus.hide()

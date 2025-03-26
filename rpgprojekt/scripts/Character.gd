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
#@export var skills: Array
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
	hp = hp - (damage-defense/4)
	animation_player.play("hurt")
	# Tween: Move left relative to current position
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(-5, 0), 0.2)
	await tween.finished
	
	_update_hp_bar()
	
	await get_tree().create_timer(0.5).timeout

	# Tween: Move right (overshooting to the right side relative to the current position)
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(2 * 5, 0), 0.2)
	await tween.finished

	await get_tree().create_timer(0.5).timeout

	tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(-5, 0), 0.2)
	await tween.finished
	print(str(damage) + " damage has been taken by " + name)
	await get_tree().create_timer(0.5).timeout
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

func _update_hp_bar():
	progress_bar.value = (hp/max_hp) * 100

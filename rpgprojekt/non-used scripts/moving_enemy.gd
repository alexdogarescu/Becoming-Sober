extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null
@export var player_hit = false


func _physics_process(_delta):
	pass
	#if player_chase:
		#position += (player.position - position)/speed
		#$AnimatedSprite2D.play("walk")
		
		#if(player.position.x-position.x)<0:
			#$AnimatedSprite2D.flip_h = true
		#else:
			#$AnimatedSprite2D.flip_h = false
		#This flips the sprite in the right direction.
		#if player_hit: 
			#change_scene()
		
		
	#else:
		#d$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
func change_scene():
	get_tree().change_scene_to_file("res://scenes/battle_scene.tscn")
	player_hit = false
	player_chase = false

func _on_hit_area_body_entered(body):
	player_hit = true

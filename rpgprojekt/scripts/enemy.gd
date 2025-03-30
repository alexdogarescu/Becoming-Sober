extends CharacterBody2D

class_name Enemy

var speed = 25
var player_chase = false
var player = null
@export var player_hit = false


func _physics_process(_delta):
	if player_chase:
		position += (player.position - position)/speed
		#d$AnimatedSprite2D.play("walk")
		
		#if(player.position.x-position.x)<0:
			#$AnimatedSprite2D.flip_h = true
		#else:
			#$AnimatedSprite2D.flip_h = false
		#This flips the sprite in the right direction.
		#if player_hit: 
			#change_scene()
		
		
	#else:
	#	$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	$"../scene_changer".change_to("res://scenes/battle_scene.tscn")
	
	#player = body
	#player_chase = true

# We don't need those, as we already built the scenechanger
#func _on_detection_area_body_exited(body):
	#player = null
	#player_chase = false
	
#func change_scene():
	#get_tree().change_scene_to_file("res://scenes/battle_scene.tscn")
	#player_hit = false
	#player_chase = false

#func _on_hit_area_body_entered(body):
	#player_hit = true

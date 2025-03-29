class_name Player

extends CharacterBody2D

@export var speed = 100
@export var inv: Inventory
var current_dir = "none"
@onready var pickup_area = $pickup_area

#This is written in GL script not C#!
#I tried writing code in C# but I got an error. Will look into it
#GLScript should do just fine tho

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("down"):
		current_dir = "down"
#		play_anim(1)
	elif Input.is_action_pressed("up"):
		current_dir = "up"
#		play_anim(1)
	elif Input.is_action_pressed("left"):
		current_dir = "left"
#		play_anim(1)
	elif Input.is_action_pressed("right"):
		current_dir = "right"
#		play_anim(1)
	#these are defined under project and then input actions
	velocity = direction * speed
	#if !direction: #direction is variable of Vector2 so it's (0, 0) here. !(0,0) is basically acting like 1
#		play_anim(0)
	move_and_slide() #function that moves the given object
	#if Input.is_action_just_pressed("e"):
		#collect(ItemNode.new())
		#check_pickup()
	
#this is the basic input movement for 2d top-down games in godot
#UP TO HERE NO REASON TO CHANGE THE CODE, adding is sufficient

#func play_anim(movement):
#	var dir = current_dir
#	var anim = $AnimatedSprite2D #animation player object
#	#I don't know if the code could be cleaner than this
#	if dir == "right":
#		anim.flip_h = false
#		if movement:
#			anim.play("walk_side")
#		else: anim.play("idle_side")
#	elif dir == "left":
#		anim.flip_h = true
#		if movement:
#			anim.play("walk_side")
#		else: anim.play("idle_side")
#	elif dir == "up":
#		if movement:
#			anim.play("walk_up")
#		else: anim.play("idle_up")
#	elif movement:
#		anim.play("walk_down")
#	else: anim.play("idle_down")
	



	
func collect(item):
	#if is ItemNode
	inv.insert(item)
	print("item picked")



#func _on_item_picked_up(item: Item):
	#inv.append(item)
	#print("Picked up:", item.name)



#func _on_pickup_area_body_entered(body: Node2D) -> void:
	#if body.has_method("item_node"):
		#inv.insert(body.get_item())

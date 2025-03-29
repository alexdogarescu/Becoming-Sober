class_name ItemNode

extends Node2D

var empty_bottle = preload("res://Items/Item-Scenes-res/empty_bottle.tscn")
@export var item: Item
var player= null
var player_in_area = false
signal item_picked

var player_in_range = null
@onready var area:Area2D = $pickable_area
#@onready var area:Area2D = $item_node

func _process(delta):
	if player_in_area == true:
		if Input.is_action_just_pressed("e"):
			collect_item()
	
func collect_item():
	#var item_instance = empty_bottle.instantiate()
	player.collect(item)
	self.queue_free()

func get_area():
	return area

func get_item():
	return item

#func _ready():
	#if item:
		#update_item_display()
	#connect("body_entered", _on_body_entered)
	#connect("body_exited", _on_body_exited)


#func update_item_display():
	#var sprite = $Sprite2D
	#if sprite:
		#sprite.texture = item.texture 

#func _on_body_entered(body):
	#if body.is_in_group("player"):
		#player_in_range = body

#func _on_body_exited(body):
	#if body == player_in_range:
		#player_in_range = null
		

#func pick_up():
	#if player_in_range:
		#item_picked.emit(item)
		#queue_free()
	  

func _on_pickable_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body

func _on_pickable_area_body_exited(body):
	if body is Player:
		player_in_area = false

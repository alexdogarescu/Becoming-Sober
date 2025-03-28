class_name ItemNode
#eventually try and make this a class
extends Node2D

@export var item: Item
var player = null
var player_in_area = false
signal item_picked

var player_in_range = null
@onready var area:Area2D = $pickable_area
#@onready var area:Area2D = $item_node


func collect_item():
	player.collect(item)

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
	  

func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body
		$".".queue_free()

func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

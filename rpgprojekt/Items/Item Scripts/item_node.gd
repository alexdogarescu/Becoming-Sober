class_name ItemCollectible
#CAN ALSO BE STATICBODY2D
extends Node2D

@export var item: Item
var player= null
var player_in_area = false
signal item_picked

var player_in_range = null
@onready var area:Area2D = $pickable_area

func _process(delta):
	if player_in_area == true:
		if Input.is_action_just_pressed("e"):
			collect_item()
	
func collect_item():
	player.collect(item)
	await get_tree().create_timer(0.1).timeout
	self.queue_free()

func get_area():
	return area

func get_item():
	return item


func _on_pickable_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body

func _on_pickable_area_body_exited(body):
	if body is Player:
		player_in_area = false

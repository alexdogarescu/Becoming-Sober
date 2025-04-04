extends Control

@onready var inv: Inventory = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

#probably a better way to do this than is_open var...
var is_open = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()

func _input(event):
	if event.is_action_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func close():
	visible = false
	is_open = false
	get_tree().paused = false
	
func open():
	is_open = true
	visible = true
	get_tree().paused = true

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	

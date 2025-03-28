extends Resource

class_name Inventory

signal update

@export var slots: Array[InvSlot] 

func insert(item: Item):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if !item_slots.is_empty():
		item_slots[0].amount += 1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
	update.emit()



#func add_item(item: Item, amount: int = 1):
	#if item.name in items:
		#items[Item].quantity += amount
	#else:
		#var new_item = item.duplicate()
		#new_item.quantity = amount
		#items[Item] = new_item

#func remove_item(item_name: String, amount: int = 1):
	#if item_name in items:
		#items[Item].quantity -= amount
		#if items[Item].quantity <= 0:
			#items.erase(item_name)

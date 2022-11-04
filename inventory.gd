extends Node2D

const SlotClass = preload("res://slot.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null


# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in inventory_slots.get_children():
		slot.gui_input.connect(slot_gui_input.bind(slot))


func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		print("GOT HERE")
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				# Empty slot
				if !slot.item: # place holding item to slot
					slot.putIntoSlot(holding_item)
					holding_item = null
				# Slot has an item
				else: # Swap holding item with item in slot
					# holding different items
					if holding_item.item_name != slot.item.item_name:
						var temp_item = slot.item
						slot.pickFromSlot()
						temp_item.global_position = event.global_position
						slot.putIntoSlot(holding_item)
						holding_item = temp_item
					else:
						var stack_size = int(JSONData.item_data[slot.item.item_name]["StackSize"])
						var able_to_add = stack_size - slot.item.item_quantity
						# If the amount that we're able to add is more than the amount held
						if able_to_add >= holding_item.item_quantity:
							slot.item.add_item_quantity(holding_item.item_quantity)
							holding_item.queue_free()
							holding_item = null
						# holding too much, about to exceed stack size. some will be 
						# still left held
						else:
							slot.item.add_item_quantity(able_to_add)
							holding_item.decrease_item_quantity(able_to_add)
			elif slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()
				

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

extends Node2D

const SlotClass = preload("res://slot.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null


# Called when the node enters the scene tree for the first time.
func _ready():
	for slot in inventory_slots.get_children():
		slot.gui_input.connect(slot_gui_input.bind(slot))


func slot_gui_input(event: InputEvent, slot: SlotClass):
	print("INVENTORY slot_gui_input")
	if event is InputEventMouseButton:
		print("GOT HERE")
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item: # place holding item to slot
					slot.putIntoSlot(holding_item)
					holding_item = null
				else: # Swap holding item with item in slot
					var temp_item = slot.item
					slot.pickFromSlot()
					temp_item.global_position = event.global_position
					slot.putIntoSlot(holding_item)
					holding_item = temp_item
			elif slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()
				

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

extends Node2D

var item_name
var item_quantity

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = randi() % 3
	if rand == 0:
		item_name = "Iron Sword"
		$TextureRect.texture = load("res://item_icons/Iron Sword.png")
	elif rand == 1:
		item_name = "Tree Branch"
		$TextureRect.texture = load("res://item_icons/Tree Branch.png")
	else:
		item_name = "Slime Potion"		
	$TextureRect.texture = load("res://item_icons/" + item_name + ".png")
	var stack_size = int(JSONData.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1

	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String.num_int64(item_quantity)


func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String.num_int64(item_quantity)
	
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String.num_int64(item_quantity)

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://item_icons/Iron Sword.png")
	else:
		$TextureRect.texture = load("res://item_icons/Tree Branch.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

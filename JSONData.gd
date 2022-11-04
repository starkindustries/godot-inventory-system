extends Node

var item_data: Dictionary

func _ready():
	item_data = LoadData("res://data/ItemData.json")
	
func LoadData(file_path):
	var data = FileAccess.open(file_path, FileAccess.READ)
	var json_data = JSON.parse_string(data.get_as_text())
	return json_data

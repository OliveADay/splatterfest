extends Node2D

var world_resource = preload("res://world.tscn")
var score_file_path = "user://score.cfg"

func _ready() -> void:
	$CanvasLayer/Label2.text = "personal best: "+str(load_best_score())

func _on_button_pressed() -> void:
	var world = world_resource.instantiate()
	add_child(world)
	$CanvasLayer.visible = false
	
func load_best_score() -> int:
	var config = ConfigFile.new()
	var error = config.load(score_file_path)
	if error!=OK:
		return 0
	return config.get_value("main","best_score")

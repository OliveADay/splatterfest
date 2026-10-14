extends Node2D

var world_resource = preload("res://world.tscn")

func _on_button_pressed() -> void:
	var world = world_resource.instantiate()
	add_child(world)
	$CanvasLayer.visible = false

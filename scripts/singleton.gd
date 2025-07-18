extends Node

var character_resource = "res://resources/pippa.tres"

func choose_player(new_character_resource: String):
	character_resource = new_character_resource
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func get_character_resource() -> String:
	return character_resource

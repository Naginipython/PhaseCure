class_name PlayerData
extends Resource

@export var bullet: PackedScene = preload("res://scenes/Players/bullet.tscn")
@export var sprite: CompressedTexture2D = preload("res://icon.svg")
@export var bullet_handler_script: Script = preload("res://scripts/characters/bullet_handler.gd")

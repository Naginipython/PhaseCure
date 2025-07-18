extends Node2D

const XP = preload("res://scenes/xp.tscn")
@onready var player: Player = $Player

func _on_enemy_spawned(enemy_instance: Variant) -> void:
	enemy_instance.connect("enemy_died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died(pos: Vector2) -> void:
	var xp_instance = XP.instantiate()
	xp_instance.global_position = pos
	add_child(xp_instance)

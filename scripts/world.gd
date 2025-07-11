extends Node2D

const EXP = preload("res://scenes/exp.tscn")

func _on_enemy_spawner_enemy_spawned(enemy_instance: Variant) -> void:
	enemy_instance.connect("enemy_died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died(pos: Vector2) -> void:
	print("drop exp")
	var exp_instance = EXP.instantiate()
	exp_instance.global_position = pos
	add_child(exp_instance)

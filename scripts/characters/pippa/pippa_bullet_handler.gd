extends Node

func shoot(bullet: PackedScene):
	for i in range(0,2):
		var mouse_pos = get_parent().get_global_mouse_position()
		var bullet_instance = bullet.instantiate()
		var dir = (mouse_pos - get_parent().global_position).normalized()
		var offset: int = 15
		bullet_instance.rotation = dir.angle()
		bullet_instance.global_position = get_parent().global_position + dir * offset
		add_child(bullet_instance)
		await get_tree().create_timer(0.2).timeout

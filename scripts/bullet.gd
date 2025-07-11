extends Area2D

const SHOOT_SPEED: int = 200
const DAMAGE: float = 5.0

func _on_visible_notifier_screen_exited() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * SHOOT_SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	print("hit enemy")
	area.take_damage(DAMAGE)
	queue_free()

extends Area2D

const SHOOT_SPEED: int = 200

func _on_visible_notifier_screen_exited() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * SHOOT_SPEED * delta

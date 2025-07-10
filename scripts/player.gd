extends CharacterBody2D

const SPEED := 100.0
var can_shoot: bool = true
var bullet_scene: Resource
@onready var bullet_container: Node = $BulletContainer
@onready var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	bullet_scene = preload("res://scenes/bullet.tscn")

func _physics_process(delta: float) -> void:
	var x_input := Input.get_axis("left", "right")
	var y_input := Input.get_axis("up", "down")
	
	if x_input:
		velocity.x = x_input * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if y_input:
		velocity.y = y_input * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and can_shoot:
		var pos = get_global_mouse_position()
		print(pos)
		var bullet_instance = bullet_scene.instantiate()
		var myPos: Vector2 = global_position
		var dir = (pos - myPos).normalized()
		bullet_instance.rotation = dir.angle()
		bullet_instance.global_position = global_position + dir * 15
		bullet_container.add_child(bullet_instance)
		can_shoot = false
		shoot_timer.start()


func _on_timer_timeout() -> void:
	can_shoot = true

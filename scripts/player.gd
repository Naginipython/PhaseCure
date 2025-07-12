extends CharacterBody2D

const BULLET_SCENE = preload("res://scenes/bullet.tscn")

@onready var bullet_container: Node = $BulletContainer
@onready var shoot_timer: Timer = $ShootTimer
@onready var healthbar: ProgressBar = $Healthbar
@onready var full_health_timer: Timer = $Healthbar/fullHealthTimer
@onready var health_regen_timer: Timer = $Healthbar/healthRegenTimer

const SPEED := 100.0
var can_shoot: bool = true
var hp: int = 100
var max_hp: int = 100
var regen: int = 5

#### Engine Functions

func _physics_process(delta: float) -> void:
	check_health()
	move_player(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and shoot_timer.is_stopped():
		var mouse_pos = get_global_mouse_position()
		var bullet_instance = BULLET_SCENE.instantiate()
		var dir = (mouse_pos - global_position).normalized()
		var offset: int = 15
		bullet_instance.rotation = dir.angle()
		bullet_instance.global_position = global_position + dir * offset
		bullet_container.add_child(bullet_instance)
		shoot_timer.start()
		
#### Signal Functions

func _on_area_2d_area_entered(area: Area2D) -> void:
	area.player_in_range()

func _on_full_health_timer_timeout() -> void:
	healthbar.visible = false
	
func _on_health_regen_timer_timeout() -> void:
	hp += regen

#### My Functions

func move_player(_delta: float) -> void:
	var x_input := Input.get_axis("left", "right")
	var y_input := Input.get_axis("up", "down")
	# Move X
	if x_input:
		velocity.x = x_input * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Move Y
	if y_input:
		velocity.y = y_input * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

func take_damage(dmg: int) -> void:
	hp -= dmg
	health_regen_timer.start()

func get_exp(_type: int) -> void:
	print("get exp")

func check_health() -> void:
	if healthbar.max_value != max_hp:
		healthbar.max_value = max_hp
	
	if hp >= max_hp:
		hp = max_hp
		if full_health_timer.is_stopped() and healthbar.visible:
			full_health_timer.start()
	else:
		healthbar.visible = true
		healthbar.value = hp
		if health_regen_timer.is_stopped():
			health_regen_timer.start()

class_name Player extends CharacterBody2D

const BULLET_SCENE = preload("res://scenes/Players/bullet.tscn")

@onready var sprite: Sprite2D = $Sprite
@onready var bullet_handler: Node = $BulletHandler
@onready var shoot_timer: Timer = $ShootTimer
@onready var healthbar: ProgressBar = $Healthbar
@onready var full_health_timer: Timer = $Healthbar/fullHealthTimer
@onready var health_regen_timer: Timer = $Healthbar/healthRegenTimer
@onready var screen_ui: CanvasLayer = %ScreenUI

var can_shoot: bool = true

@export var character: PlayerData

@export_group("Health")
@export var hp: int = 100
@export var max_hp: int = 100
@export var regen: int = 5

@export_group("Stats")
@export var speed: float = 100.0
#@export var fire_rate: float = 5.0
#crit chance, 

@export_group("Experience")
@export var xp: int = 0
@export var max_xp: int = 100
@export var level: int = 1

#### Engine Functions

func _ready() -> void:
	character = load(Singleton.get_character_resource())
	sprite.texture = character.sprite
	bullet_handler.set_script(character.bullet_handler_script)

func _physics_process(delta: float) -> void:
	check_health()
	move_player(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and shoot_timer.is_stopped():
		#bullet_handler.shoot(character.bullet)
		#shoot(character.bullet)
		bullet_handler.shoot(character.bullet)
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
		velocity.x = x_input * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	# Move Y
	if y_input:
		velocity.y = y_input * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
	move_and_slide()

func take_damage(dmg: int) -> void:
	hp -= dmg
	health_regen_timer.start()

func get_xp(_type: int) -> void:
	xp += 10
	if xp >= max_xp:
		xp %= max_xp
		max_xp = floor(max_xp * 1.1) # +10% needed
		screen_ui.set_max_xp(max_xp)
		level += 1
	screen_ui.set_xp(xp)

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

#func shoot(bullet: PackedScene) -> void:
	#var mouse_pos = get_global_mouse_position()
	#var bullet_instance = bullet.instantiate()
	#var dir = (mouse_pos - global_position).normalized()
	#var offset: int = 15
	#bullet_instance.rotation = dir.angle()
	#bullet_instance.global_position = global_position + dir * offset
	#bullet_handler.add_child(bullet_instance)
	#
	#await get_tree().create_timer(0.2).timeout
	#var bullet_instance2 = bullet.instantiate()
	#var dir2 = (mouse_pos - global_position).normalized()
	#var offset2: int = 15
	#bullet_instance2.rotation = dir2.angle()
	#bullet_instance2.global_position = global_position + dir2 * offset2
	#bullet_handler.add_child(bullet_instance2)

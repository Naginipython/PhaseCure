extends Node2D

const ENEMY := preload("res://scenes/Enemy.tscn")
var time_to_spawn_enemy = true
@onready var camera: Camera2D = $Player/Camera2D
var screen_size: Vector2 
@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

func _process(delta: float) -> void:
	if time_to_spawn_enemy:
		time_to_spawn_enemy = false
		var camera_pos: Vector2 = camera.global_position
		var zoom = 4
		var half_size: Vector2 = (screen_size * 0.5) / zoom
		
		var top_left: Vector2 = camera_pos - half_size
		var bot_right: Vector2 = camera_pos + half_size
		var enemy_pos: Vector2 = generate_enemy_pos(top_left, bot_right)
		
		var enemy_instance = ENEMY.instantiate()
		enemy_instance.global_position = enemy_pos
		add_child(enemy_instance)

func generate_enemy_pos(top_left: Vector2, bot_right: Vector2) -> Vector2:
	var margin := 50
	var side := randi() % 4
	var spawn_pos: Vector2 = Vector2.ZERO
	match side:
		0: # Top
			spawn_pos.x = randf_range(top_left.x, bot_right.x)
			spawn_pos.y = top_left.y - margin
		1: # Right
			spawn_pos.x = bot_right.x + margin
			spawn_pos.y = randf_range(top_left.y, bot_right.y)
		2: # Bot
			spawn_pos.x = randf_range(top_left.x, bot_right.x)
			spawn_pos.y = bot_right.y + margin
		3: # Left
			spawn_pos.x = top_left.x - margin
			spawn_pos.y = randf_range(top_left.y, bot_right.y)
	print(side)
	return spawn_pos

extends Area2D

var player: CharacterBody2D
const SPEED: float = 25.0
var health: float = 50.0

func _ready() -> void:
	player = get_node("/root/World/Player")

func _physics_process(delta: float) -> void:
	var player_pos = player.position
	position.x = move_toward(position.x, player_pos.x, SPEED*delta)
	position.y = move_toward(position.y, player_pos.y, SPEED*delta)

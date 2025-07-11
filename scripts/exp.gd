extends Area2D

var is_player_in_range: bool = false
var player: CharacterBody2D
const SPEED: float = 100.0

func _ready() -> void:
	player = get_node("/root/World/Player")

func _physics_process(delta: float) -> void:
	if is_player_in_range:
		var player_pos = player.position
		var dir = (player_pos - position).normalized()
		position += dir * SPEED*delta

func player_in_range() -> void:
	is_player_in_range = true

func _on_body_entered(body: Node2D) -> void:
	body.get_exp(0)
	queue_free()

extends Area2D

var player: CharacterBody2D
@onready var hit_timer: Timer = $HitTimer
const SPEED: float = 35.0
@export var health: float = 20.0
@export var dmg: int = 10
var is_hitting_player: bool = false
signal enemy_died(pos)

func _ready() -> void:
	player = get_node("/root/World/Player")
	

func _physics_process(delta: float) -> void:
	var player_pos = player.position
	var dir = (player_pos - position).normalized()
	position += dir * SPEED*delta
	
	if is_hitting_player and hit_timer.is_stopped():
		player.take_damage(dmg)
		hit_timer.start()


func _on_body_entered(body: Node2D) -> void:
	is_hitting_player = true

func _on_body_exited(body: Node2D) -> void:
	is_hitting_player = false

func take_damage(dmg: float) -> void:
	health -= dmg
	if health <= 0:
		emit_signal("enemy_died", position)
		queue_free()

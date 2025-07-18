extends Control


func _on_player_pressed() -> void:
	Singleton.choose_player("res://resources/player.tres")

func _on_pippa_pressed() -> void:
	Singleton.choose_player("res://resources/pippa.tres")

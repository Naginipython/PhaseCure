extends CanvasLayer
@onready var xp_bar: ProgressBar = $GameUI/XpBar

@export var max_xp: int = 100

func set_xp(xp: int) -> void:
	xp_bar.value = xp

func set_max_xp(new_max_xp: int) -> void:
	max_xp = new_max_xp

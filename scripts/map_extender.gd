extends Node2D

const MAP = preload("res://scenes/tile_maps.tscn")
var screen_size: Vector2 
@onready var camera: Camera2D = $"../Player/Camera2D"
@onready var tile_maps: Node2D = $"map(0, 0)"
@onready var ground_tile_layer: TileMapLayer = $"map(0, 0)/GroundTileLayer"

var current_map_block := Vector2(0,0)
var zone_dict: Dictionary = {}
var map_size: Vector2

func _ready() -> void:
	zone_dict[Vector2(0,0)] = "map(0, 0)"
	screen_size = get_viewport().get_visible_rect().size
	map_size = (ground_tile_layer.get_used_rect().size * ground_tile_layer.tile_set.tile_size)

func _physics_process(_delta: float) -> void:
	var zones = get_render_zones()
	remove_zones(zones)
	render_map()

func remove_zones(zones: Dictionary) -> void:
	for zone in zone_dict:
		if not zones.has(zone):
			# Doesn't fully work
			remove_child(find_child(zone_dict[zone]))
			print("removed: " + str(zone_dict[zone]))
	zone_dict = zones

func get_render_zones() -> Dictionary:
	var result := {}
	
	var camera_pos: Vector2 = camera.global_position
	var half_size: Vector2 = (screen_size * 0.5) / camera.zoom
	var top_left: Vector2 = camera_pos - half_size
	var bot_right: Vector2 = camera_pos + half_size
	
	var char_zone: Vector2 = floor(camera_pos/map_size.x)
	var bot_right_zone: Vector2 = floor(bot_right/map_size.x)
	var top_left_zone: Vector2 = floor(top_left/map_size.x)
	
	result[char_zone] = "map" + str(char_zone)
	
	if char_zone == bot_right_zone and char_zone == top_left_zone:
		return result
	
	if char_zone != bot_right_zone:
		# Horizontal, Vertical, & Diagonal all use this
		result[bot_right_zone] = "map" + str(bot_right_zone)
		if bot_right_zone.x != char_zone.x and bot_right_zone.y != char_zone.y:
			# Diagonal extras
			var hori := Vector2(bot_right_zone.x,char_zone.y)
			result[hori] = "map" + str(hori)
			var vert := Vector2(char_zone.x,bot_right_zone.y)
			result[vert] = "map" + str(vert)
	elif char_zone != top_left_zone:
		# Horizontal, Vertical, & Diagonal all use this
		result[top_left_zone] = "map" + str(top_left_zone)
		if top_left_zone.x != char_zone.x and top_left_zone.y != char_zone.y:
			# Diagonal extras
			var hori := Vector2(top_left_zone.x,char_zone.y)
			result[hori] = "map" + str(hori)
			var vert := Vector2(char_zone.x,top_left_zone.y)
			result[vert] = "map" + str(vert)
	return result

func render_map() -> void:
	for zone in zone_dict:
		if !has_node(zone_dict[zone]):
			var map_instance = MAP.instantiate()
			map_instance.position = tile_maps.position
			map_instance.position += map_size * zone
			map_instance.name = zone_dict[zone]
			add_child(map_instance)
			pass
	pass

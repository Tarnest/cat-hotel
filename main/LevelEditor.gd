extends Node2D

@onready var main: Node2D = $".."
@onready var rooms: TileMap = $"../Rooms"
@onready var room_tile := Vector2i(1, 0)

func _ready() -> void:
	Global.add_room_pressed.connect(on_add_room_pressed)


func _unhandled_input(event: InputEvent) -> void:
	if Global.can_place_tile:
		if event.is_action_pressed("mb_left"):
			place_tile()
		elif event.is_action_pressed("mb_right"):
			remove_tile()
	
	if event.is_action_pressed("deselect") and Global.can_place_tile:
		Global.can_place_tile = false
		get_viewport().set_input_as_handled()


func place_tile() -> void:
	var mouse_pos := rooms.local_to_map(get_global_mouse_position())
	rooms.set_cells_terrain_connect(0, [mouse_pos], 0, 0)
	#rooms.set_cell(0, mouse_pos, 0, room_tile)


func remove_tile() -> void:
	var mouse_pos := rooms.local_to_map(get_global_mouse_position())
	rooms.set_cells_terrain_connect(0, [mouse_pos], 0, -1)


func on_add_room_pressed() -> void:
	Global.can_place_tile = !Global.can_place_tile

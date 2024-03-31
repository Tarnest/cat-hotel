extends Node2D

@onready var main: Node2D = $".."
@onready var camera: Camera2D = $"../Movement/Camera2D"

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
	var mouse_pos := get_global_mouse_position()
	
	var desired_x: float = floor(mouse_pos.x / 16) * 16
	var desired_y: float = floor(mouse_pos.y / 16) * 16
	
	var base_room: Node2D = Global.BASE_ROOM.instantiate()
	base_room.position = Vector2(desired_x, desired_y)
	main.add_child(base_room)


func remove_tile() -> void:
	#var mouse_pos := rooms.local_to_map(get_global_mouse_position())
	#rooms.set_cells_terrain_connect(0, [mouse_pos], 0, -1)
	pass


func on_add_room_pressed() -> void:
	Global.can_place_tile = !Global.can_place_tile

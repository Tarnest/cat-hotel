extends Node2D

@onready var main: Node2D = $".."
@onready var detect_buildings: RayCast2D = $DetectBuildings

var grid_size := 32

func _ready() -> void:
	Global.add_room_pressed.connect(on_add_room_pressed)
	Global.remove_room_pressed.connect(on_remove_room_pressed)
	Global.can_place_tile_switched.connect(can_place_tile_switched)


func _physics_process(_delta: float) -> void:
	detect_buildings.global_position = get_global_mouse_position()
	
	for child in get_children():
		if child is Room:
			var room: Room = child
			room.global_position = get_grid_mouse_position()
			break

func _unhandled_input(event: InputEvent) -> void:
	if Global.can_place_tile:
		if event.is_action_pressed("mb_left"):
			place_tile()
	
	if Global.can_remove_tile:
		if event.is_action_pressed("mb_right"):
			remove_tile()
	
	if event.is_action_pressed("deselect") and (Global.can_place_tile or Global.can_remove_tile):
		Global.can_place_tile = false
		Global.can_remove_tile = false
		get_viewport().set_input_as_handled()


func can_place_tile_switched() -> void:
	if Global.can_place_tile:
		var room: Room = Global.current_room.instantiate()
		room.global_position = get_grid_mouse_position()
		add_child(room)
	else:
		for child in get_children():
			if child is Room:
				child.queue_free()


func place_tile() -> void:
	var mouse_pos := get_grid_mouse_position()
	
	var base_room: Node2D = Global.BASE_ROOM.instantiate()
	base_room.position = mouse_pos
	main.add_child(base_room)


func remove_tile() -> void:
	if detect_buildings.is_colliding():
		var collider: Node2D = detect_buildings.get_collider()
		if detect_buildings.get_collider() is Room:
			collider.queue_free()


func on_add_room_pressed() -> void:
	Global.can_remove_tile = false
	Global.can_place_tile = !Global.can_place_tile


func on_remove_room_pressed() -> void:
	Global.can_place_tile = false
	Global.can_remove_tile = !Global.can_remove_tile


func get_grid_mouse_position() -> Vector2:
	var mouse_pos := get_global_mouse_position()
	
	var desired_x: float = floor(mouse_pos.x / grid_size) * grid_size
	var desired_y: float = floor(mouse_pos.y / grid_size) * grid_size
	
	return Vector2(desired_x, desired_y)

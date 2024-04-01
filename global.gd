extends Node

signal add_room_pressed
signal remove_room_pressed
signal marketing_pressed
signal can_place_tile_switched

const BASE_ROOM = preload("res://rooms/base_room.tscn")

var can_place_tile := false:
	set(_can_place_tile):
		can_place_tile = _can_place_tile
		can_place_tile_switched.emit()

var can_remove_tile := false
var current_room := BASE_ROOM

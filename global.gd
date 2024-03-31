extends Node

signal add_room_pressed
signal marketing_pressed

const BASE_ROOM = preload("res://rooms/base_room.tscn")

var can_place_tile := false

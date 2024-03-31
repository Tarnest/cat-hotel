extends Node2D

@onready var camera: Camera2D = $Camera2D

const MIN_ZOOM := Vector2.ONE * 0.4
const MAX_ZOOM := Vector2.ONE * 4.6
const ZOOM_INCREMENT := Vector2.ONE * 0.2
const ZOOM_RATE := 16

var is_panning := false
var target_zoom := Vector2.ONE

func _process(delta: float) -> void:
	is_panning = Input.is_action_pressed("mb_middle")
	
	camera.zoom = camera.zoom.lerp(target_zoom, ZOOM_RATE * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event
		
		if mouse_event.is_action_pressed("zoom_in"):
			target_zoom = target_zoom + ZOOM_INCREMENT
		if mouse_event.is_action_pressed("zoom_out"):
			target_zoom = target_zoom - ZOOM_INCREMENT
		
		target_zoom = target_zoom.clamp(MIN_ZOOM, MAX_ZOOM)

	if event is InputEventMouseMotion and is_panning:
		var mouse_event: InputEventMouseMotion = event
		camera.global_position -= mouse_event.relative * 1/camera.zoom

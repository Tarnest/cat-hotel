extends CanvasLayer

@onready var add_room: Button = $HBoxContainer/AddRoom
@onready var marketing: Button = $HBoxContainer/Marketing
@onready var remove_room: Button = $HBoxContainer/RemoveRoom

func _ready() -> void:
	add_room.pressed.connect(on_add_room_pressed)
	remove_room.pressed.connect(on_remove_room_pressed)
	marketing.pressed.connect(on_marketing_pressed)


func on_add_room_pressed() -> void:
	Global.add_room_pressed.emit()


func on_marketing_pressed() -> void:
	Global.marketing_pressed.emit()


func on_remove_room_pressed() -> void:
	Global.remove_room_pressed.emit()

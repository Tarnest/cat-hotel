extends CanvasLayer

@onready var add_room: Button = $HBoxContainer/AddRoom
@onready var marketing: Button = $HBoxContainer/Marketing

func _ready() -> void:
	add_room.pressed.connect(on_add_room_pressed)
	marketing.pressed.connect(on_marketing_pressed)


func on_add_room_pressed() -> void:
	Global.add_room_pressed.emit()


func on_marketing_pressed() -> void:
	Global.marketing_pressed.emit()

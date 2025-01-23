extends Node2D

signal mouse_clicked
@export var selectable : bool = false

func _on_mouse_control_gui_input(event: InputEvent) -> void:
	if selectable:
		if event is InputEventMouse:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				mouse_clicked.emit()


func _on_mouse_control_mouse_entered() -> void:
	if selectable:
		scale = Vector2(0.7,0.7)
		position.y -= 100
		z_index = 10

func _on_mouse_control_mouse_exited() -> void:
	if selectable:
		scale = Vector2(0.5,0.5)
		position.y += 100
		z_index = 0

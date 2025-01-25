extends Node2D

signal mouse_clicked
@export var selectable : bool = false

@export var hover_size_factor : Vector2 = Vector2(0.6,0.6)
@export var base_size_factor : Vector2 = Vector2(0.5,0.5)
@export var hover_displace_amt : int = 10

func _on_mouse_control_gui_input(event: InputEvent) -> void:
	if selectable:
		if event is InputEventMouse:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				mouse_clicked.emit()


func _on_mouse_control_mouse_entered() -> void:
	if selectable:
		scale = hover_size_factor
		global_position.y -= hover_displace_amt
		z_index = 10

func _on_mouse_control_mouse_exited() -> void:
	if selectable:
		scale = base_size_factor
		global_position.y += hover_displace_amt
		z_index = 0

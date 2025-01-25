extends Node2D
class_name PlayerDisplay

signal discard_pile_clicked
signal draw_pile_clicked

@onready var draw_display: Node2D = %draw_display
@onready var draw_click: Node2D = %draw_click

@onready var discard_click: Node2D = %discard_click
@onready var discard_display: Node2D = %discard_display

@onready var player_placed: Node2D = %player_placed
@onready var player_hand: Node2D = %player_hand

@export var hand_visible : bool = true

func _ready() -> void:
	if hand_visible:
		player_hand.show()
	else:
		player_hand.hide()

func _on_discard_click_mouse_clicked() -> void:
	discard_pile_clicked.emit()


func _on_draw_click_mouse_clicked() -> void:
	draw_pile_clicked.emit()

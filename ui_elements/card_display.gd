extends Node2D
class_name CardDisplay

@onready var bug_sprite: Sprite2D = %bug_sprite
@onready var element_sprite: Sprite2D = %element_sprite
@onready var psyche_sprite: Sprite2D = %psyche_sprite
@onready var description: RichTextLabel = %description

@export var cur_card : BaseCard

func _ready() -> void:
	update_icons()
	description.hide()

func set_card(new_card : BaseCard) -> void:
	cur_card = new_card

func update_icons() -> void:
	bug_sprite.texture = cur_card.bug_resource.icon
	element_sprite.texture = cur_card.element_resource.icon
	psyche_sprite.texture = cur_card.psyche_resource.icon

func _input(event: InputEvent) -> void:
	pass


func _on_mouse_control_mouse_entered() -> void:
	scale = Vector2(0.7,0.7)
	position.y -= 200
	z_index = 10
	description.text = cur_card.get_description()
	description.show()


func _on_mouse_control_mouse_exited() -> void:
	scale = Vector2(0.5,0.5)
	position.y += 200
	z_index = 0
	description.hide()



func _on_mouse_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			print(cur_card.bug_resource)
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			print(cur_card.get_description())

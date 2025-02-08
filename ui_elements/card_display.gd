extends Node2D
class_name CardDisplay

@warning_ignore("unused_signal")
signal mouse_clicked(cur_card : CardDisplay)
signal mouse_right_clicked(cur_card : CardDisplay)

@onready var bug_sprite: Sprite2D = %bug_sprite
@onready var element_sprite: Sprite2D = %element_sprite
@onready var psyche_sprite: Sprite2D = %psyche_sprite
@onready var description: RichTextLabel = %description
@onready var border_color: ColorRect = %border_color

@export var cur_card : BaseCard

@export var hover_size_factor : Vector2 = Vector2(0.8,0.8)
@export var base_size_factor : Vector2 = Vector2(0.5,0.5)
@export var hover_displace_amt : int = 60

var description_offset : int = 250
var description_width : int = 700
var upside_down_offset : int = -1280 # viewport width
var height_offset : int = -700

var selected : bool = false

var player_name : String = ""

func _ready() -> void:
	scale = base_size_factor
	update_icons()
	description.hide()
	description.size.x = description_width

func set_card(new_card : BaseCard) -> void:
	cur_card = new_card

func update_icons() -> void:
	bug_sprite.texture = cur_card.bug_resource.icon
	element_sprite.texture = cur_card.element_resource.icon
	psyche_sprite.texture = cur_card.psyche_resource.icon

func _input(_event: InputEvent) -> void:
	pass


func _on_mouse_control_mouse_entered() -> void:
	scale = hover_size_factor
	global_position.y -= hover_displace_amt
	z_index = 10
	description.text = cur_card.get_description()
	# align description
	if (global_rotation_degrees >= 91) or (global_rotation_degrees <= -91):
		description.rotation_degrees = 180
		description.position.y = upside_down_offset
	else:
		description.rotation_degrees = 0
		description.position.y = height_offset
	if self.global_position.x > 0:
		description.position.x = -description_offset - description_width
	else:
		description.position.x = description_offset
	description.show()


func _on_mouse_control_mouse_exited() -> void:
	scale = base_size_factor
	global_position.y += hover_displace_amt
	z_index = 0
	description.hide()


func _on_mouse_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			#mouse_clicked.emit(self)
			toggle_selected()
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			mouse_right_clicked.emit(self)

func toggle_selected():
	if not selected:
		#check if maximum selection amoutn given context is reached yet
		border_color.color = Color.ORANGE
		selected = true
		add_to_group("selected")
	else:
		border_color.color = Color.hex(0x171717ff)
		selected = false
		remove_from_group("selected")

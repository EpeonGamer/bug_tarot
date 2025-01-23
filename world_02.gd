extends Node2D

var hand_hover_offset : int = 180

#var players : Array = []
var player_1 : PlayerStats = PlayerStats.new()
var card_display := preload("res://ui_elements/card_display.tscn")

#region Collection Elements
@onready var player_hand: Node2D = %player_hand

@onready var player_placed: Node2D = %player_placed

@onready var player_draw_pile: Node2D = %player_draw_pile
@onready var draw_display: Node2D = %draw_display
@onready var draw_click: Node2D = %draw_click

@onready var player_discard_pile: Node2D = %player_discard_pile
@onready var discard_display: Node2D = %discard_display
@onready var discard_click: Node2D = %discard_click
#endregion

#region Testing Elements
@export var testing : bool = false
@export var hand_limit_test : int = 3
@export var placed_limit_test : int = 3
@export var draw_limit_test : int = 3
@export var discard_limit_test : int = 3
#endregion

func _ready() -> void:
	if testing:
		run_test_1()
	

#region Testing functions
func run_test_1() -> void:
	var test_cards : Array = []
	var card1 : BaseCard = BaseCard.new()
	var card2 : BaseCard = BaseCard.new()
	
	card1.bug_resource = load("res://card_aspects/bug_aspects/ant_base.tres")
	card1.element_resource = load("res://card_aspects/element_aspects/barrier_base.tres")
	card1.psyche_resource = load("res://card_aspects/psyche_aspects/servant_base.tres")
	
	card2.bug_resource = load("res://card_aspects/bug_aspects/grub_base.tres")
	card2.element_resource = load("res://card_aspects/element_aspects/fire_base.tres")
	card2.psyche_resource = load("res://card_aspects/psyche_aspects/sloth_base.tres")
	
	test_cards = [card1,card2]
	for i in hand_limit_test:
		card2 = card2.duplicate(true)
		player_1.hand.append(card2)
	for i in placed_limit_test:
		card2 = card2.duplicate(true)
		player_1.placed_cards.append(card2)
	for i in draw_limit_test:
		card2 = card2.duplicate(true)
		player_1.draw_pile.append(card2)
	for i in discard_limit_test:
		card2 = card2.duplicate(true)
		player_1.discard_pile.append(card2)
		
	for i : BaseCard in player_1.hand:
		i.randomize_aspects()
	for i : BaseCard in player_1.placed_cards:
		i.randomize_aspects()
	for i : BaseCard in player_1.draw_pile:
		i.randomize_aspects()
	for i : BaseCard in player_1.discard_pile:
		i.randomize_aspects()
	
	display_hand(player_1)
	display_placed(player_1)
	arrange_draw_pile()
	arrange_discard_pile()
#endregion

func display_hand(player_stats: PlayerStats) -> void:
	# rework to consider which player this is, or have this be the singlepalyer framework
	for i in range(player_hand.get_child_count()-1):
		player_hand.get_children()[i].queue_free()
	for i in player_hand.get_children():
		player_hand.remove_child(i)
		
		
	var hand = player_stats.hand
	for card in hand:
		var new_card_cont : CardDisplay = card_display.instantiate()
		new_card_cont.set_card(card)
		player_hand.add_child(new_card_cont)
	arrange_hand()

func display_placed(player_stats: PlayerStats) -> void:
	# rework to consider which player this is, or have this be the singlepalyer framework
	for i in player_placed.get_children():
		i.queue_free()
		
	var hand = player_stats.placed_cards
	for card in hand:
		var new_card_cont : CardDisplay = card_display.instantiate()
		new_card_cont.set_card(card)
		player_placed.add_child(new_card_cont)
	arrange_placed()

func arrange_hand():
	var num_cards = player_hand.get_children().size()
	if num_cards == 0:
		return
	
	var offset = (num_cards - 1) / 2.0
	var max_rotation = 12.0  # Max rotation in degrees
	var max_spacing_x = 400.0  # Horizontal spacing
	var max_spacing_y = 50.0  # Vertical bow effect

	for i in range(num_cards):
		var cur_card = player_hand.get_children()[i]
		
		# Calculate relative position and rotation
		var relative_index = i - offset
		cur_card.rotation_degrees = relative_index * max_rotation / (offset + 1)
		cur_card.position.x = relative_index * max_spacing_x / (offset + 1)
		cur_card.position.y = pow(relative_index, 2) * max_spacing_y / pow(offset + 1, 2)  # Bow effect

func arrange_placed() -> void:
	var num_cards = player_placed.get_children().size()
	if num_cards == 0:
		return
	
	var offset = (num_cards - 1) / 2.0
	var max_rotation = 2.0  # Max rotation in degrees
	var max_spacing_x = 800.0  # Horizontal spacing
	var max_spacing_y = 50.0  # Vertical bow effect

	for i in range(num_cards):
		var cur_card = player_placed.get_children()[i]
		
		# Calculate relative position and rotation
		var relative_index = i - offset
		cur_card.rotation_degrees = relative_index * max_rotation / (offset + 1)
		cur_card.position.x = relative_index * max_spacing_x / (offset + 1)
		cur_card.position.y = pow(relative_index, 2) * max_spacing_y / pow(offset + 1, 2)  # Bow effect

func arrange_draw_pile() -> void:
	var size := player_1.draw_pile.size()
	if size > 2:
		draw_display.show()
		draw_click.show()
	elif size > 1:
		draw_display.hide()
		draw_click.show()
	else:
		draw_display.hide()
		draw_click.hide()
		

func arrange_discard_pile() -> void:
	var size := player_1.discard_pile.size()
	if size > 2:
		discard_display.show()
		discard_click.show()
	elif size > 1:
		discard_display.hide()
		discard_click.show()
	else:
		discard_display.hide()
		discard_click.hide()
		

#region Functionality
func _on_check_button_toggled(toggled_on: bool) -> void:
	if !toggled_on:
		player_hand.position.y += -hand_hover_offset
	else:
		player_hand.position.y += hand_hover_offset

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_focus_next"):
		$main_control/CheckButton.set("button_pressed",!$main_control/CheckButton.button_pressed)
#endregion


func _on_draw_click_mouse_clicked() -> void:
	player_1.draw_cards(1,false)
	arrange_draw_pile()
	display_hand(player_1)


func _on_discard_click_mouse_clicked() -> void:
	pass # Replace with function body.

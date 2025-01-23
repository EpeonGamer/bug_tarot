extends Node2D

#var players : Array = []
var player_1 : PlayerStats = PlayerStats.new()
var card_display := preload("res://ui_elements/card_display.tscn")
@onready var player_hand: Node2D = %player_hand
@export var hand_limit_test : int = 3

func _ready() -> void:
	var test_cards : Array = []
	var card1 : BaseCard = BaseCard.new()
	var card2 : BaseCard = BaseCard.new()
	
	card1.bug_resource = load("res://card_aspects/bug_aspects/ant_base.tres")
	card1.element_resource = load("res://card_aspects/element_aspects/barrier_base.tres")
	card1.psyche_resource = load("res://card_aspects/psyche_aspects/servant_base.tres")
	
	card1.bug_resource = load("res://card_aspects/bug_aspects/grub_base.tres")
	card1.element_resource = load("res://card_aspects/element_aspects/fire_base.tres")
	card1.psyche_resource = load("res://card_aspects/psyche_aspects/sloth_base.tres")
	
	test_cards = [card1,card2]
	for i in hand_limit_test:
		player_1.hand.append_array(test_cards)
	
	display_hand(player_1)
	

func display_hand(player_stats: PlayerStats) -> void:
	# rework to consider which player this is, or have this be the singlepalyer framework
	var hand = player_stats.hand
	for card in hand:
		var new_card_cont : CardDisplay = card_display.instantiate()
		new_card_cont.set_card(card)
		player_hand.add_child(new_card_cont)
	arrange_hand()
	#for i in player_hand.get_children().size():
		#var cur_card : CardDisplay = player_hand.get_children()[i]
		#var offset : float = ( (-1.0 + player_hand.get_children().size()) / 2)
		#cur_card.rotation_degrees += ( i - offset) * max(12.0 - (offset * 1.6),0)
		#print(offset)
		#cur_card.position.x += ( i - offset) * (150 - (offset * 10))
		#cur_card.position.y += max(abs( i - offset) * (15.0 - (offset * 0.02)),0)

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

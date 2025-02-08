extends Node2D
class_name  ClientsideCardHandler

var hand_hover_offset : int = 180

#var players : Array = []
var player_1 : PlayerStats = PlayerStats.new()
var player_2 : PlayerStats = PlayerStats.new()

var card_display := preload("res://ui_elements/card_display.tscn")

#region Collection Elements
@onready var player_display_1: PlayerDisplay = %player_display_1
@onready var player_display_2: PlayerDisplay = %player_display_2

#endregion

#region Testing Elements
@export var testing : bool = false
@export var hand_limit_test : int = 3
@export var placed_limit_test : int = 3
@export var draw_limit_test : int = 3
@export var discard_limit_test : int = 3

@export var p2_discard_limit_test : int = 3
@export var p2_placed_limit_test : int = 3
@export var p2_draw_limit_test : int = 3
@export var p2_hand_limit_test : int = 3
#endregion

func _ready() -> void:
	update_other_player(2)
	
	
	if testing:
		run_test_player_1()
	

#region Testing functions
func run_test_player_1() -> void:
	var card2 : BaseCard = BaseCard.new()
	
	card2.bug_resource = load("res://card_aspects/bug_aspects/grub_base.tres")
	card2.element_resource = load("res://card_aspects/element_aspects/fire_base.tres")
	card2.psyche_resource = load("res://card_aspects/psyche_aspects/sloth_base.tres")
	
#region Player 1
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
		
	display_hand(player_1,player_display_1)
	display_placed(player_1,player_display_1)
	arrange_draw_pile(player_1, player_display_1)
	arrange_discard_pile(player_1, player_display_1)
#endregion
		
#region Player 2
	for i in p2_discard_limit_test:
		card2 = card2.duplicate(true)
		player_2.discard_pile.append(card2)
	for i in p2_draw_limit_test:
		card2 = card2.duplicate(true)
		player_2.draw_pile.append(card2)
	for i in p2_placed_limit_test:
		card2 = card2.duplicate(true)
		player_2.placed_cards.append(card2)
	for i in p2_hand_limit_test:
		card2 = card2.duplicate(true)
		player_2.hand.append(card2)
		
	for i : BaseCard in player_2.discard_pile:
		i.randomize_aspects()
	for i : BaseCard in player_2.draw_pile:
		i.randomize_aspects()
	for i : BaseCard in player_2.placed_cards:
		i.randomize_aspects()
	for i : BaseCard in player_2.hand:
		i.randomize_aspects()
		
	update_other_player(2)
	player_1.all_discard_amt_granted = 2
#endregion	
#endregion

#region Display Hand/Placed
func display_cards(container: Node2D, cards: Array, on_card_clicked: Callable) -> void:
	# Clear the container
	for i in range(container.get_child_count() - 1):
		container.get_children()[i].queue_free()
	for child in container.get_children():
		container.remove_child(child)
		
	# Add new cards to the container
	for card in cards:
		var new_card_cont: CardDisplay = card_display.instantiate()
		new_card_cont.set_card(card)
		new_card_cont.mouse_clicked.connect(on_card_clicked)
		new_card_cont.mouse_right_clicked.connect(_on_face_card_right_clicked) #consider parameter for assigning
		container.add_child(new_card_cont)
		


func display_hand(player_stats: PlayerStats, player_display : PlayerDisplay) -> void:
	display_cards(player_display.player_hand, player_stats.hand, _on_face_card_clicked)
	arrange_hand(player_display)


func display_placed(player_stats: PlayerStats, player_display : PlayerDisplay) -> void:
	display_cards(player_display.player_placed, player_stats.placed_cards, _on_face_card_clicked)
	arrange_placed(player_display)
#endregion


#region Arrange Cards
#region Spaced Cards
func arrange_cards(container: Node2D, max_rotation: float, max_spacing_x: float, max_spacing_y: float) -> void:
	if container.get_child_count() == 0:
		return
	
	var num_cards = container.get_children().size()
	var offset = (num_cards - 1) / 2.0
	
	for i in range(num_cards):
		var cur_card: CardDisplay = container.get_children()[i]
		
		# Calculate relative position and rotation
		var relative_index = i - offset
		cur_card.rotation_degrees = relative_index * max_rotation / (offset + 1)
		cur_card.position.x = relative_index * max_spacing_x / (offset + 1)
		cur_card.position.y = pow(relative_index, 2) * max_spacing_y / pow(offset + 1, 2)  # Bow effect


func arrange_hand(player_display: Node) -> void:
	arrange_cards(player_display.player_hand, 12.0, 300.0, 50.0)

func arrange_placed(player_display: Node) -> void:
	arrange_cards(player_display.player_placed, 2.0, 500.0, 20.0)
#endregion

func arrange_pile(pile : Array, display : Node2D, click : Node2D) -> void:
	var size : int = pile.size()
	if size > 1:
		display.show()
		click.show()
	elif size > 0:
		display.hide()
		click.show()
	else:
		display.hide()
		click.hide()

func arrange_draw_pile(player_stats: PlayerStats, player_display : PlayerDisplay) -> void:
	arrange_pile(player_stats.draw_pile, player_display.draw_display, player_display.draw_click)

func arrange_discard_pile(player_stats: PlayerStats, player_display : PlayerDisplay) -> void:
	arrange_pile(player_stats.discard_pile, player_display.discard_display, player_display.discard_click)

#endregion

#region Functionality
func _on_check_button_toggled(toggled_on: bool) -> void:
	if !toggled_on:
		player_display_1.player_hand.position.y += -hand_hover_offset
	else:
		player_display_1.player_hand.position.y += hand_hover_offset

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_focus_next"):
		$main_control/CheckButton.set("button_pressed",!$main_control/CheckButton.button_pressed)
#endregion

#region Own cards clicked

func _on_face_card_clicked(cur_card : CardDisplay) -> void:
	match cur_card.get_parent():
		player_display_1.player_hand:
			player_1.transfer_card(player_1,"hand",player_1,"placed_cards",cur_card.cur_card)
			display_placed(player_1,player_display_1)
			display_hand(player_1,player_display_1)
		player_display_1.player_placed:
			player_1.transfer_card(player_1,"placed_cards",player_1,"hand",cur_card.cur_card)
			display_placed(player_1,player_display_1)
			display_hand(player_1,player_display_1)

func _on_face_card_right_clicked(cur_card : CardDisplay) -> void:
	player_1.transfer_card(player_1,"placed_cards",player_1,"hand",cur_card.cur_card)
	player_1.discard_cards([cur_card.cur_card])
	display_placed(player_1,player_display_1)
	display_hand(player_1,player_display_1)
	arrange_discard_pile(player_1, player_display_1)


func _on_player_hand_1_discard_pile_clicked() -> void:
	player_1.move_cards(player_1,"discard_pile",player_1,"hand",1,false)
	arrange_discard_pile(player_1, player_display_1)
	display_hand(player_1,player_display_1)


func _on_player_display_1_draw_pile_clicked() -> void:
	player_1.draw_cards(1,false)
	arrange_draw_pile(player_1, player_display_1)
	display_hand(player_1,player_display_1)
#endregion


func _on_player_display_2_discard_pile_clicked() -> void:
	var cur_player = player_1
	#check if this player (player_1) can take cards from the discard pile of this player (or any players)
	#ordered from specific and required to general granted
	# Update discard amounts, see process discard function
	cur_player.other_discard_amt_required = process_discard(cur_player.other_discard_amt_required, player_2, player_1, player_display_2, player_display_1)
	cur_player.all_discard_amt_required = process_discard(cur_player.all_discard_amt_required, player_2, player_1, player_display_2, player_display_1)
	cur_player.other_discard_amt_granted = process_discard(cur_player.other_discard_amt_granted, player_2, player_1, player_display_2, player_display_1)
	cur_player.all_discard_amt_granted = process_discard(cur_player.all_discard_amt_granted, player_2, player_1, player_display_2, player_display_1)

# Consolidated function to handle discard checks, returns new value for discard amts
func process_discard(amount, player_2, player_1, player_display_2, player_display_1):
	if amount > 0:
		player_2.move_cards(player_2, "discard_pile", player_1, "hand", 1, false)
		arrange_discard_pile(player_2, player_display_2)
		display_hand(player_1, player_display_1)
		return amount - 1
	return amount


#region Other player display
func update_other_player(player_num : int):
	match player_num:
		2:
			display_hand(player_2, player_display_2)
			display_placed(player_2,player_display_2)
			arrange_discard_pile(player_2,player_display_2)
			arrange_draw_pile(player_2,player_display_2)
#endregion

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

#region Statemachine vars
var action_queue : Array = []
var state : ActionElement = ActionElement.new()
#endregion

func _ready() -> void:
	reset_for_turn_start()
	
	update_other_player(2)
	
	if testing:
		run_test_player_1()
		player_2.player_name = "Voidd"
	

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
		var element : ActionElement =  ActionElement.new()
		element.action_type = Autoload.ACTION_TYPE.PLACE
		i.bug_resource.place_action = element
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
#endregion	
#endregion

#region Display Hand/Placed
func display_cards(container: Node2D, cards: Array, on_card_clicked: Callable) -> void:
	# Clear seleted selection
	clear_selected()
	
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
		new_card_cont.player_name = player_1.player_name
		
		container.add_child(new_card_cont)
		


func display_hand(player_stats: PlayerStats, player_display : PlayerDisplay) -> void:
	display_cards(player_display.player_hand, player_stats.hand, _on_face_card_clicked)
	arrange_hand(player_display)


func display_placed(player_stats: PlayerStats, player_display : PlayerDisplay) -> void:
	display_cards(player_display.player_placed, player_stats.placed_cards, _on_face_card_clicked)
	arrange_placed(player_display)

func clear_selected() -> void:
	for i : CardDisplay in get_tree().get_nodes_in_group("selected"):
		i.toggle_selected()
		

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
		
	# Place selected card
	# Check if card can be placed, statemachine compatible, etc. etc.
	if Input.is_action_just_pressed("ui_page_up") and ((state.action_type == Autoload.ACTION_TYPE.PLACE and state.number > 0) or not player_1.default_card_placed):
			#get player by name function called here
			var selected_cards : Array = get_tree().get_nodes_in_group("selected")
			if selected_cards:
				var card : CardDisplay = selected_cards[selected_cards.size()-1]
				if card.player_name == player_1.player_name:
					if card.cur_card.cur_location == Autoload.CARD_LOCATION.HAND:
						action_queue.append(card.cur_card.bug_resource.place_action.duplicate())
						player_1.transfer_card(player_1,"hand",player_1,"placed_cards",card.cur_card)
						display_hand(player_1,player_display_1)
						display_placed(player_1,player_display_1)
						
						if state.action_type == Autoload.ACTION_TYPE.PLACE and state.number > 0:
							# NOT CURRENTLY ABLE TO HANDLE MULTIPLE SIMULTANEOUSLY PLACED CARDS
							state.number -= 1
							step_action_queue()
						else:
							player_1.default_card_placed = true
							step_action_queue()
						print(state)
				else:
					print("Not your card!")
#endregion


#region Statemachine
func step_action_queue()->void:
	if not action_queue.is_empty():
		change_state(action_queue.pop_front())
	else:
		var new_action = ActionElement.new()
		new_action.number = 0
		change_state(new_action)
		print("State queue end reached.")
		# Logic required at end of state queue, tick turn over?
		# Manual turn ending is best, could be paired with timer

func change_state(action: ActionElement)->void:
	state = action
#endregion

#region Turn handler
func reset_for_turn_start() -> void:
	player_1.default_card_discarded = false
	player_1.default_card_placed = false
	player_1.default_card_reactvated = false
	state = ActionElement.new()
	state.number = 0
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
	#TODO Test free discard or state
	player_1.move_cards(player_1,"discard_pile",player_1,"hand",1,false)
	arrange_discard_pile(player_1, player_display_1)
	display_hand(player_1,player_display_1)


func _on_player_display_1_draw_pile_clicked() -> void:
	#TODO Draw amt control
	if (state.action_type == Autoload.ACTION_TYPE.DRAW) and (state.number != 0):
		player_1.draw_cards(state.number,false)
		step_action_queue()
	elif player_1.hand.is_empty() and action_queue.is_empty(): #empty action_queue means turn start
		player_1.draw_cards(2,false)
	#TODO "deny" sfx when neither of above applies
	arrange_draw_pile(player_1, player_display_1)
	display_hand(player_1,player_display_1)
#endregion


#region cross-player discard
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
func process_discard(amount, player_2_stats, player_1_stats, player_display_2_ref, player_display_1_ref):
	if amount > 0:
		player_2_stats.move_cards(player_2_stats, "discard_pile", player_1_stats, "hand", 1, false)
		arrange_discard_pile(player_2_stats, player_display_2_ref)
		display_hand(player_1_stats, player_display_1_ref)
		return amount - 1
	return amount
#endregion


#region Other player display
func update_other_player(player_num : int):
	match player_num:
		2:
			display_hand(player_2, player_display_2)
			display_placed(player_2,player_display_2)
			arrange_discard_pile(player_2,player_display_2)
			arrange_draw_pile(player_2,player_display_2)
#endregion

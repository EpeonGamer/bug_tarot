extends Resource
class_name PlayerStats

@export var player_name: String = "Epeon"
#var placed_limit : int = 3

# Signals for card-related events
@warning_ignore("unused_signal")
signal card_moved(source_player: PlayerStats, source_name: String, target_player: PlayerStats, target_name: String, card: BaseCard)
@warning_ignore("unused_signal")
signal cards_moved(source_player: PlayerStats, source_name: String, target_player: PlayerStats, target_name: String, cards: Array)

var handler : ClientsideCardHandler = null

#default without playing cards, once per round
var default_card_placed : bool = false
var default_card_reactvated : bool = false
var default_card_discarded : bool = false

#default without playing cards, once per player turn

#region Card Collections
var draw_pile: Array = []
var hand: Array = []
var placed_cards: Array = []
var discard_pile: Array = []
#endregion

#region Generalized Card Movement
func move_cards(
	source_player: PlayerStats, source_name: String,
	target_player: PlayerStats, target_name: String,
	amount: int, allow_partial: bool = false
) -> Array:
	"""
	Moves cards between collections, optionally across players.

	Args:
		source_player (PlayerStats): The player who owns the source collection.
		source_name (String): The name of the source collection (e.g., "draw_pile").
		target_player (PlayerStats): The player who owns the target collection.
		target_name (String): The name of the target collection (e.g., "hand").
		amount (int): The number of cards to move.
		allow_partial (bool): Whether to allow fewer cards if the source has insufficient cards.

	Returns:
		Array: The moved cards.
	"""
	var source = source_player._get_collection_by_name(source_name)
	var target = target_player._get_collection_by_name(target_name)

	if source == [] or target == null: #check for empty is not accurate check
		printerr("Invalid source or target collection:", source_name, "->", target_name)
		return []

	if amount > source.size() and !allow_partial:
		printerr("Player {", source_player.player_name, "} cannot move cards: Not enough cards in", source_name)
		return []

	var move_count = min(amount, source.size())
	var moved_cards: Array = []
	for i in range(move_count):
		var card = _move_single_card(source, target)
		if card:
			moved_cards.append(card)

	if moved_cards.size() > 0:
		emit_signal("cards_moved", source_player, source_name, target_player, target_name, moved_cards)

	return moved_cards

func _move_single_card(source: Array, target: Array) -> BaseCard:
	"""
	Moves a single card from a source collection to a target collection.
	"""
	if source.size() == 0:
		printerr("Cannot move card: Source collection is empty.")
		return null

	var card = source.pop_back()
	target.append(card)
	return card
#endregion

#region Specific Actions
func draw_cards(amount: int, allow_partial: bool = false) -> Array:
	"""
	Draws cards from the player's draw pile to their hand.
	"""
	return move_cards(self, "draw_pile", self, "hand", amount, allow_partial)

func discard_cards(cards: Array) -> void:
	"""
	Discards specific cards from the player's hand to their discard pile.
	"""
	for card in cards:
		if hand.has(card):
			discard_pile.append(card)
			hand.erase(card)
			emit_signal("card_moved", self, "hand", self, "discard_pile", card)

func transfer_card(
	source_player: PlayerStats, source_name: String,
	target_player: PlayerStats, target_name: String,
	card: BaseCard
) -> void:
	"""
	Transfers a specific card from one player's collection to another.
	"""
	var source = source_player._get_collection_by_name(source_name)
	var target = target_player._get_collection_by_name(target_name)

	if source == null or target == null:
		printerr("Invalid source or target collection for card transfer:", source_name, "->", target_name)
		return

	if source.has(card):
		source.erase(card)
		target.append(card)
		emit_signal("card_moved", source_player, source_name, target_player, target_name, card)
#endregion

#region Shuffle Functions
func shuffle_collection(collection_name: String) -> void:
	"""
	Shuffles the specified card collection.
	"""
	var collection = _get_collection_by_name(collection_name)
	if collection != null:
		collection.shuffle()
#endregion

#region Utility Functions
func move_discard_to_draw(shuffle: bool = true) -> void:
	"""
	Moves all cards from the discard pile back to the draw pile.
	Optionally shuffles the draw pile.
	"""
	move_cards(self, "discard_pile", self, "draw_pile", discard_pile.size(), true)
	if shuffle:
		shuffle_collection("draw_pile")

func count_all_cards() -> int:
	"""
	Returns the total number of cards across all collections.
	"""
	return draw_pile.size() + hand.size() + placed_cards.size() + discard_pile.size()

func _get_collection_by_name(collection_name: String) -> Array:
	"""
	Returns the collection (array) corresponding to the given name.
	"""
	match collection_name:
		"draw_pile":
			return draw_pile
		"hand":
			return hand
		"placed_cards":
			return placed_cards
		"discard_pile":
			return discard_pile
		_:
			return []
#endregion

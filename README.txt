# Current State:
	Unplayable - Lacking functionality
# Future ideas
1. Cards that have effects during another player's turn, especially if one of your placed cards is discarded.
# Design Choices
1. Effects occur on turn played or in reaction to another effect. This prevents frustration in keeping track of delayed effects etc..
2. Roles:
	1. Bugs are responsible for the main effect of the card
	2. Elements add flavour to a card
	3. psyche adds situational strategy to a card
3. All aspect (bug, element, psyche) descriptions terminate in full stops.
# Coding
## TODO
1. In `world_01`, set up a `card_container` for each card in the active hand dynamically. Rotate each slightly to simulate a held hand. Leave space to see the rest of the play area.
2. Provide detection for which card is being hovered over, but only during that player's turn, unless it is a reactionary effect (`illusion`, `barrier`, `fire`).
## Action types
1. Draw
	1. If cards are available to draw from
		1. Up to certain number
2. Place
	1. If space available on board
	2. If certain card allows it
3. Discard
	1. Choose card or opponent chooses
	2. Replace card discarded
		1. Do not activate it's "place" ability
4. Swap a card
	1. Potentially of another player
5. React to effect applied to another card
	1. In a hand
	2. Active
## Board states
1. Cards are all not interactable.
2. When a card is placed/reactivated, relevant cards must be highlighted until a mi or max limit is reached.
3. After an "accept" input, the action(s) must be carried out.

# Gameplay
## Setup
1. Each player must have a shuffled deck of a least 9 cards. All players must have an equal amount of cards before at the start of the game.
2. Each player must be dealt 4 cards from this deck, and place one card down face-up, making it "placed". This does not trigger the "Place" ability. Place the rest of the deck face-down and to one side of the play area.
3. Determine a starting player, and proceed clockwise if required.
## Player turn
Unless otherwise stated:
1. If fewer than 3 (of the current player's) cards are placed, you may place one card and then must use its "place" ability, making it placed. A card cannot be placed if the "place" ability cannot trigger. This can only be done once per turn.
2. You may use the "reactivate" ability of one placed card per turn. This cannot be a card you placed this turn.
3. Discarded cards are placed face-down into a separate pile that may not be drawn from. If you discard another player's card, it must be placed in their discard pile.
4. The turn can proceed in any order.
5. If you start your turn with no cards, draw up to two.
6. Declare when a psyche or element is used for clarity, these abilities do not have to be used if the player does not wish to use them.
7. The cost for a psyche must be paid before its effect takes place.
8. Trade variation:
	1. A player may offer up one, and only one, of the cards in their hand to trade for another. Another player can trade any card in their hand, any of their active cards, or the top card from their discard pile, should the player who's turn it is, accept.
## Resolution
1. The game automatically concludes after five rounds (every player has taken a turn), or when a player has no cards left in their deck or hand. At this stage the player with the most cards in their discard pile wins.
2. A player wins immediately if they cause another to have no placed or held cards.
3. A player wins immediately if they have five cards in their hand and:
	1. They have three placed cards with the same psyche or element, or
	2. They have two cards of the same bug, and two cards of the same psyche or element.
## Clarification:
1. "Any card" includes opponent's cards unless otherwise stated.
2. Unless otherwise stated, when a player must draw a card it will be the topmost card from their deck (not the discard pile).
3. Effects are resolved in the order they are triggered unless otherwise stated.
4. "You" refers to the player who's controlling the card.
# Card Elements
## Bugs
1. Wasp
	1. Place: Up to two of any placed cards of your choice must be discarded, and their player must place new cards in their place where possible. This does not trigger their "place" ability.
	2. Reactivate: One placed card of your choice must be discarded, and their player must place new cards in their place where possible. This does not trigger their "place" ability.
2. Mantis
	1. Place: Take any currently placed card into your hand.
	2. Reactivate: Swap any two placed cards.
3. Roach
	1. Place: Discard any number of your cards and draw up to the same number.
	2. Reactivate: If fewer than four cards are placed for you, place another card and trigger its "place" effect.
4. Beetle
	1. Place: Take the top card of any discard pile into your hand.
	2. Reactivate: Take the top card of any discard pile into your hand.
5. Worm
	1. Place: Swap any held hand with that of another player.
	2. Reactivate: Swap any held card with one of another player.
6. Moth
	1. Place: Select one player to reveal their hand to you.
	2. Reactivate: All placed cards with the fire element are returned to their player's hand.
7. Butterfly
	1. Place: Look at the top three cards of your deck and replace them at the top in any order.
	2. Reactivate: Choose any one card with the wrath psyche and discard it.
8. Earwig
	1. Place: Choose another player. They must choose one of their placed cards to discard.
	2. Reactivate: Choose any one card with the barrier element and discard it.
9. Fly
	1. Place: For every placed card with the servant psyche, discard any one card of your choice.
	2. Reactivate: All cards with the sloth element are returned to their player's hand.
10. Pillbug
	1. Place: Take the top two cards from any discard piles into your hand.
	2. Reactivate: Discard this card and any two others.
11. Spider
	1. Place: Choose one element type. Discard all cards with that type.
	2. Reactivate: Choose any one card with the swarm element and discard it.
12. Snail
	1. Place: Take up to three cards from any discard piles and place them at the top of your deck.
	2. Reactivate: Trigger the "place" ability of one of your placed cards.
13. Ant
	1. Place: Take all placed cards with the swarm element and add them to the top of your deck.
	2. Reactivate: Draw a card, and if you have less than 4 placed cards, you can place one card and use its "place" effect.
14. Centipede
	1. Place: Discard any card, and then discard up to two of your cards and draw up to three.
	2. Reactivate: Discard any one of your cards, and reactivate one of your placed cards.
15. Locust
	1. Place: Choose one psyche type. Discard all cards with that type.
	2. Reactivate: All other players must discard one card from their hand if possible.
16. Grub
	1. Place: Draw up to three cards.
	2. Reactivate: Draw one card.
17. Mosquito
	1. Place: Choose one psyche type. Each player with a card with that psyche must discard a card.
	2. Reactivate: Reactivate one of another player's placed cards as one of your own. The card remains theirs afterwards.
## Elements
1. Swarm
	1. Trigger: Another swarm card is placed or reactivated by you, while this card is placed.
	2. Action: If no other swarm cards than the triggering cards of you have been reactivated this turn, this card can be reactivated.
2. Fire
	1. Trigger: This card would be affected by another card.
	2. Action: The same affect is also applied to the triggering card if applicable. This is limited to the triggering card, and is applied after the effects of the original card.
3. Illusion
	1. Trigger: The illusion card is not placed and any placed card would be affected.
	2. Action: You can swap the illusion card with the affected card, instead applying the affect to the illusion card. Swapping with an opponent's card gives them control of this card.
4. Barrier
	1. Trigger: The barrier card is placed and another placed card would be affected.
	2. Action: The other card is unaffected and the effect applies to the barrier card instead.
## Psyche
1. Wrath
	1. Effect: The reactivate effect of this card applies to one additional card.
	2. Cost: One other of your placed cards must be discarded.
	3. Condition: Another player has discarded a card on your turn, and this card is placed
2. Sloth
	1. Effect: Shuffle your hand into your deck, then draw up to two cards.
	2. Cost: This card must be discarded
	3. Condition: This card is not placed
3. Servant
	1. Effect: You may place an additional card this turn, triggering its "place" ability
	2. Cost: Choose one of your placed cards and move it to another player's hand
	3. Condition: No players have discarded cards on your turn, and this card is placed, and you have less than four placed cards.

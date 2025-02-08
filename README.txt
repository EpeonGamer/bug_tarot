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
1. See code #TODOs
2. Button to shuffle discard pile back into draw pile
3. Button to shuffle draw pile
4. Provide detection for which card is being hovered over, but only during that player's turn, unless it is a reactionary effect (`illusion`, `barrier`, `fire`).
	1. Highlight cards for interaction (when only applies to those cards)
5. Show info on card moves granted/required (separate menu probs)
6. Pass reference to game handler to cards, so they can trigger methods to queue and activate certain states in it (as well as query select limits)
	1. Statemachine controlling whether drawing etc..
		1. Label to communicate state and limits
## Board states
7. Cards are all not interactable.
8. When a card is placed/reactivated, relevant cards must be highlighted until a mi or max limit is reached.
9. After an "accept" input, the action(s) must be carried out.
## Card aspect range (can be combined and compounded, range can be excluded):
### Bug:
10. Player
	1. Self
	2. Other
	3. Any
	4. All
	5. Choice
		1. Current player chooses
		2. Other chooses
	6. Other's card as own (temporary)
11. Count limit
	1. Granted (up to; should be able to reference actual amt chosen)
	2. Required
12. Applies to
	1. Placed card
	2. Hand
	3. Discard pile
	4. Draw pile (see topmost number of cards)
	5. Card(s) present (in hand, placed, etc.)
	6. Card aspect:
		1. Bug
		2. Element
		3. Psyche
13. Outcome
	1. Discard (to who's pile?)
	2. Take (into hand, draw)
		1. Consider take into placed and discard
		2. Move to another player's hand/placed etc.
	3. Swap (certain amount; select first, confirm before swapping, destination)
	4. Place (given default or new limit)
		1. With activating place aspect
		2. Without activating place aspect
	5. Look
		1. Draw pile or player hand
		2. Replace in order
	6. Shuffle (draw pile, maybe discard pile as well)
		1. Shuffle card/hand into draw pile
	7. Retrigger
		1. Placed
		2. Reactivate
### Elements (specific)
14. Trigger
	1. Action
		1. Placed
		2. Drawn
		3. Discarded
		4. Reactivated
		5. Retrieved from discard pile?
	2. Affected (by other card)
		1. This card
		2. Other card(s)
	3. Condition
		2. Placed
		3. Not placed
15. Action
	1. Trigger after action applies
		1. To new card (esp. swapped)
### Psyche (specific)
16. Effect:
	1. Applies to additional card(s)
17. Cost
	1. Action to other/this card before/after effect)
18. Condition
	1. Card(s) placed/discarded/drawn/etc. or not this turn by self/any/other/etc.
## Dev Notes
19. Nerf centipede or buff grub since similar effects
	1. Roach lack of limitation is also very powerful, as is snail
20. Unify draw and discard pile (since players don't want to discard other's cards given win condition)?
	1. Change win condition for end-game rush
21. Specify whether hand, placed, or discard pile affected.
22. Simplify player range (scope) to self or other
	1. You can only effect hand, placed, OR deck/discard.
23. Re-evaluate deckbuilding as all same bug/psyche/element means quick win
	1. Maybe limit to 3 cards, whole deck build for special game mode, and/or shuffle all player hands together before game.
24. Large decks can get iffy (multiple grubs plus roach), see limited "game mode as standard" idea.
25. What to do when a player has discarded all of their cards?
	1. Your cards are easily lost to another player, especially when swapping hands. This severely limits your options, including card recovery.

# Card aspect range rescope:
## General
26. Player (one playing chooses)
	1. Self
	2. Other (just 1 other player)
	3. ~~Other's card as own?~~
27. Count limit
	4. Granted
28. Applies to
	1. Placed card (s)
	2. Hand
	3. Discard pile
	4. Card aspect:
		1. Bug
		2. Element
		3. Psyche
29. Outcome
	1. Discard (to their player's pile)
### Element specific
30. Trigger
	1. Affected (by other card)
		1. This card
	2. Condition
		2. Placed
31. Action
	1. Effect after trigger applies
### Psyche specific
32. Effect:
	1. ~~Applies to additional cards~~
33. Cost
	2. Action to other/this card before/after effect.
34. Condition
	1. Cards discarded or not by others this turn.

## Redesign game cycle
### Turn cycles
### Click design
35. Draw pile
	1. Left click to draw to hand
	2. If you can view cards, do that instead
36. Discard pile
	1. If you can draw from discard, do so (up to max or one at a time?)
37. Hand
	2. Left click then click on discard or hand to place on discard or placed if allowed
	3. Right click?
38. Placed cards
	4. Left click then click on discard or hand to place on discard or placed if allowed
	5. Right click?

#### Required
- Tracking and showing selected cards
- States to handle card effects sequentially
	- Picking cards to discard and submitting selection etc.

# Gameplay
## Setup
39. Each player must have a shuffled deck of a least 9 cards. All players must have an equal amount of cards before at the start of the game.
40. Each player must be dealt 4 cards from this deck, and place one card down face-up, making it "placed". This does not trigger the "Place" ability. Place the rest of the deck face-down and to one side of the play area.
41. Determine a starting player, and proceed clockwise if required.
## Player turn
Unless otherwise stated:
42. If fewer than 3 (of the current player's) cards are placed, you may place one card and then must use its "place" ability, making it placed. A card cannot be placed if the "place" ability cannot trigger. This can only be done once per turn.
43. You may use the "reactivate" ability of one placed card per turn. This cannot be a card you placed this turn.
44. Discarded cards are placed face-down into a separate pile that may not be drawn from. If you discard another player's card, it must be placed in their discard pile.
45. The turn can proceed in any order.
46. If you start your turn with no cards, you may draw up to two as a free action.
47. You may also discard 1 of your held or placed cards on your turn as a free action.
48. Declare when a psyche or element is used for clarity, these abilities do not have to be used if the player does not wish to use them.
	1. These can only be used on the player's turn, unless the trigger/condition includes cards not limited to the current player being "affected" by other cards or otherwise stated.
49. The cost for a psyche must be paid before its effect takes place.
50. Only one psyche or element can be used per player per turn, so you can use an illusion card once on another player's turn for example.
51. Trade variation:
	1. A player may offer up one, and only one, of the cards in their hand to trade for another. Another player can trade any card in their hand, any of their active cards, or the top card from their discard pile, should the player who's turn it is, accept.
## Resolution
52. The game automatically concludes after five rounds (every player has taken a turn), or when a player has no cards left in their deck or hand. At this stage the player with the most cards in their discard pile wins.
53. A player wins immediately if they cause another to have no placed or held cards.
54. A player wins immediately if they have five cards in their hand and:
	1. They have three placed cards with the same psyche or element, or
	2. They have two cards of the same bug, and two cards of the same psyche or element.
## Clarification:
55. "Any card" includes opponent's cards unless otherwise stated.
56. Unless otherwise stated, when a player must draw a card it will be the topmost card from their deck (not the discard pile).
57. Effects are resolved in the order they are triggered unless otherwise stated.
58. "You" refers to the player who's controlling the card.
# Card Elements
## Bugs
59. Wasp
	1. Place: Up to two of any placed cards of your choice must be discarded, and their player must place new cards in their place where possible. This does not trigger their "place" ability.
	2. Reactivate: One placed card of your choice must be discarded, and their player must place new cards in their place where possible. This does not trigger their "place" ability.
60. Mantis
	1. Place: Take any currently placed card into your hand.
	2. Reactivate: Swap any two placed cards.
61. Roach
	1. Place: Discard any number of your cards and draw up to the same number.
	2. Reactivate: If fewer than four cards are placed for you, place another card and trigger its "place" effect.
62. Beetle
	1. Place: Take the top card of any discard pile into your hand.
	2. Reactivate: Take the top card of any discard pile into your hand.
63. Worm
	1. Place: Swap any held hand with that of another player.
	2. Reactivate: Swap any held card with one of another player.
64. Moth
	1. Place: Select one player to reveal their hand to you.
	2. Reactivate: All placed cards with the fire element are returned to their player's hand.
65. Butterfly
	1. Place: Look at the top three cards of your deck and replace them at the top in any order.
	2. Reactivate: Choose any one card with the wrath psyche and discard it.
66. Earwig
	1. Place: Choose another player. They must choose one of their placed cards to discard.
	2. Reactivate: Choose any one card with the barrier element and discard it.
67. Fly
	1. Place: For every placed card with the servant psyche, discard any one card of your choice.
	2. Reactivate: All placed cards with the sloth element are returned to their player's hand.
68. Pillbug
	1. Place: Take the top two cards from any discard piles into your hand.
	2. Reactivate: Discard this card and any two others.
69. Spider
	1. Place: Choose one element type. Discard all cards with that type.
	2. Reactivate: Choose any one card with the swarm element and discard it.
70. Snail
	1. Place: Take up to three cards from any discard piles and place them at the top of your deck.
	2. Reactivate: Trigger the "place" ability of one of your placed cards.
71. Ant
	1. Place: Take all placed cards with the swarm element and add them to the top of your deck.
	2. Reactivate: Draw a card, and if you have less than 4 placed cards, you can place one card and use its "place" effect.
72. Centipede
	1. Place: Discard any card, and then discard up to two of your cards and draw up to three.
	2. Reactivate: Discard any one of your cards, and reactivate one of your placed cards.
73. Locust
	1. Place: Choose one psyche type. Discard all cards with that type.
	2. Reactivate: All other players must discard one card from their hand if possible.
74. Grub
	1. Place: Draw up to three cards.
	2. Reactivate: Draw one card.
75. Mosquito
	1. Place: Choose one psyche type. Each player with a card with that psyche must discard a card.
	2. Reactivate: Reactivate one of another player's placed cards as one of your own. The card remains theirs afterwards.
## Elements
76. Swarm
	1. Trigger: Another swarm card is placed or reactivated by you, while this card is placed.
	2. Action: If no other swarm cards than the triggering cards of you have been reactivated this turn, this card can be reactivated.
77. Fire
	1. Trigger: This card would be affected by another card.
	2. Action: The same effect is also applied to the triggering card if applicable. This is limited to the triggering card, and is applied after the effects of the original card.
78. Illusion
	1. Trigger: The illusion card is not placed and any placed card would be affected.
	2. Action: You can swap the illusion card with the affected card, instead applying the affect to the illusion card. Swapping with an opponent's card gives them control of this card.
79. Barrier
	1. Trigger: The barrier card is placed and another placed card would be affected.
	2. Action: The other card is unaffected and the effect applies to the barrier card instead.
## Psyche
80. Wrath
	1. Effect: The reactivate effect of this card applies to one additional card.
	2. Cost: One other of your placed cards must be discarded.
	3. Condition: Another player has discarded a card on your turn, and this card is placed.
81. Sloth
	1. Effect: Shuffle your hand into your deck, then draw up to two cards.
	2. Cost: This card must be discarded.
	3. Condition: This card is not placed.
82. Servant
	1. Effect: You may place an additional card this turn, triggering its "place" ability.
	2. Cost: Choose one of your placed cards and move it to another player's hand.
	3. Condition: No players have discarded cards on your turn, and this card is placed, and you have less than four placed cards.

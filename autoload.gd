extends Node

enum CARD_LOCATION{
	DRAW,
	HAND,
	PLACED,
	DISCARD
}

enum ASPECT_TYPE{
	BUG,
	ELEMENT,
	PSYCHE
}

enum ACTION_TYPE{
	NONE,
	DRAW,
	DISCARD,
	PLACE,
	TAKE_INTO_HAND
}

enum PLAYER_TYPE{
	SELF,
	OTHER,
	ANY #not supported at time of writing
}

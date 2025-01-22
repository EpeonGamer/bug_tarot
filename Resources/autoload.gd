extends Node

enum BUG_TYPE{
	WASP,
	MANTIS,
	ROACH,
	BEETLE,
	WORM,
	BUTTERFLY,
	EARWIG,
	FLY,
	GRUB,
	PILLBUG,
	SPIDER,
	SNAIL,
	ANT,
	CENTIPEDE,
	LOCUST,
	MOSQUITO,
	MOTH
}

enum ELEMENT_TYPE{
	BARRIER,
	FIRE,
	ILLUSION,
	SWARM
}

enum PSYCHE_TYPE{
	SERVANT,
	SLOTH,
	WRATH
}

enum CARD_STATE{
	DRAW,
	HAND,
	PLACED,
	DISCARD,
}

func get_bug_icon(index : BUG_TYPE = 0) -> Texture:
	var output : Texture = null
	match index:
		BUG_TYPE.WASP:
			output = preload("res://icons/bug_icons/wasp_progart.png")
	return output
	

func get_element_icon(index : ELEMENT_TYPE = 0) -> Texture:
	var output : Texture = null
	match index:
		ELEMENT_TYPE.BARRIER:
			output = preload("res://icons/element_icons/barrier_progart.png")
	return output
	

func get_psyche_icon(index : PSYCHE_TYPE = 0) -> Texture:
	var output : Texture = null
	match index:
		PSYCHE_TYPE.SERVANT:
			output = preload("res://icons/psych_icons/servant_progart.png")
	return output
	

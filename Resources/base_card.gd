extends Resource
class_name BaseCard

enum CARD_STATE{
	DRAW,
	HAND,
	PLACED,
	DISCARD
}

@export var bug_resource : BaseBug = BaseBug.new()
@export var element_resource : BaseElement = BaseElement.new()
@export var psyche_resource : BasePsyche = BasePsyche.new()

var reactivated : bool = false
var state : CARD_STATE = CARD_STATE.DRAW

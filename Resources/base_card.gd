extends Resource
class_name BaseCard

#enum CARD_STATE{
	#DRAW,
	#HAND,
	#PLACED,
	#DISCARD
#}

var heading_size : int = 40
var subheading_size : int = 28
var text_size : int = 24

@export var bug_resource : BaseBug = BaseBug.new()
@export var element_resource : BaseElement = BaseElement.new()
@export var psyche_resource : BasePsyche = BasePsyche.new()

var reactivated : bool = false
#var state : CARD_STATE = CARD_STATE.DRAW


func get_description() -> String:
	var output : String = "[color=yellow]"
	output += str("[font_size=%s][color=purple]BUG: " % str(heading_size),bug_resource.name,"[/color][/font_size]\n")
	output += str("[font_size=%s][color=orange][font_size=%s]Place:[/font_size][/color] " % [str(text_size),str(subheading_size)],bug_resource.place_description,"[/font_size]\n")
	output += str("[font_size=%s][color=orange][font_size=%s]Reactivate:[/font_size][/color] " % [str(text_size),str(subheading_size)],bug_resource.reactivate_description,"[/font_size]\n\n")
	
	output += str("[font_size=%s][color=purple]ELEMENT: " % str(heading_size),element_resource.name,"[/color][/font_size]\n")
	output += str("[font_size=%s][color=orange][font_size=%s]Action:[/font_size][/color] " % [str(text_size),str(subheading_size)],element_resource.action_description,"[/font_size]\n")
	output += str("[font_size=%s][color=orange][font_size=%s]Trigger:[/font_size][/color] " % [str(text_size),str(subheading_size)],element_resource.trigger_description,"[/font_size]\n\n")
	
	output += str("[font_size=%s][color=purple]PSYCHE: " % str(heading_size),psyche_resource.name,"[/color][/font_size]\n")
	output += str("[font_size=%s][color=orange][font_size=%s]Condition:[/font_size][/color] " % [str(text_size),str(subheading_size)],psyche_resource.condition_description,"[/font_size]\n")
	output += str("[font_size=%s][color=orange][font_size=%s]Cost:[/font_size][/color] " % [str(text_size),str(subheading_size)],psyche_resource.cost_description,"[/font_size]\n")
	output += str("[font_size=%s][color=orange][font_size=%s]Effect:[/font_size][/color] " % [str(text_size),str(subheading_size)],psyche_resource.effect_description,"[/font_size]\n\n")
	
	output += "[/color]"
	return output

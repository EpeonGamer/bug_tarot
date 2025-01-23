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

func randomize_aspects() -> void:
	var new_bug : BaseBug = null
	var new_element : BaseElement = null
	var new_psyche : BasePsyche = null
	
	var dir_name := "res://card_aspects/bug_aspects/"
	var files := DirAccess.get_files_at(dir_name)
	var random_index := randi_range(0,files.size() - 1)
	new_bug = load(str(dir_name,files[random_index]))
	
	dir_name = "res://card_aspects/element_aspects/"
	files = DirAccess.get_files_at(dir_name)
	random_index = randi_range(0,files.size() - 1)
	new_element = load(str(dir_name,files[random_index]))
	
	dir_name = "res://card_aspects/psyche_aspects/"
	files = DirAccess.get_files_at(dir_name)
	random_index = randi_range(0,files.size() - 1)
	new_psyche = load(str(dir_name,files[random_index]))
	
	bug_resource = new_bug
	element_resource = new_element
	psyche_resource = new_psyche
	pass

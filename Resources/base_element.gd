extends CardAspect
class_name BaseElement

@export_multiline var trigger_description : String = "Another swarm card is placed or reactivated by you, while this card is placed."
@export_multiline var action_description : String = "If no other swarm cards than the triggering cards of you have been reactivated this turn, this card can be reactivated."

func _init() -> void:
	aspect_type = Autoload.ASPECT_TYPE.ELEMENT
	#name = "Swarm"
	#icon = load("res://icons/element_icons/swarm_progart.png")

extends CardAspect
class_name BaseBug

@export_multiline var place_description : String = "Take all placed cards with the swarm element and add them to the top of your deck."
@export_multiline var reactivate_description : String = "Draw a card, and if you have less than 4 placed cards, you can place one card and use its 'place' effect."

#replace with bug-specific class if expansion required
@export var place_action : ActionElement = ActionElement.new()
#replace with bug-specific class if expansion required
@export var reactivate_action : ActionElement = ActionElement.new()

func _init() -> void:
	aspect_type = Autoload.ASPECT_TYPE.BUG

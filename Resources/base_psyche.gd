extends CardAspect
class_name BasePsyche

@export_multiline var condition_description : String = "Another player has discarded a card on your turn, and this card is placed."
@export_multiline var cost_description : String = "One other of your placed cards must be discarded."
@export_multiline var effect_description : String = "The reactivate effect of this card applies to one additional card."

func _init() -> void:
	aspect_type = Autoload.ASPECT_TYPE.PSYCHE
	#name = "Wrath"
	#icon = load("res://icons/psyche_icons/wrath_progart.png")

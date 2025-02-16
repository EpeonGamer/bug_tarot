extends Resource
class_name ActionElement

#@export var aspect_type : Autoload.ASPECT_TYPE

#not implemented
@export var required : bool = false

@export var player_type : Autoload.PLAYER_TYPE = Autoload.PLAYER_TYPE.SELF
@export var action_type : Autoload.ACTION_TYPE = Autoload.ACTION_TYPE.NONE
@export var number : int = 1

func _to_string() -> String:
	var output : String = ""
	output += str("Action: ",Autoload.ACTION_TYPE.keys()[action_type]," | Amount: ",number," | Required: ", required," | Player: ",Autoload.PLAYER_TYPE.keys()[player_type],"\n")
	return output

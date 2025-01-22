extends Node2D

@onready var card_ratio: CardContainer = %card_ratio

var bug_icon = card_ratio.bug_icon
var element_icon = card_ratio.element_icon
var psyche_icon = card_ratio.psyche_icon

var player_1_stats : PlayerStats = PlayerStats.new()
@export var initial_card : BaseCard = BaseCard.new()

func _ready() -> void:
	var second_card = BaseCard.new()
	second_card.bug_resource = preload("res://card_aspects/bug_aspects/earwig_base.tres")
	second_card.bug_resource = preload("res://card_aspects/bug_aspects/earwig_base.tres")
	second_card.bug_resource = preload("res://card_aspects/bug_aspects/earwig_base.tres")
	
	var initial_cards : Array = [initial_card]
	player_1_stats._move_single_card(initial_cards,player_1_stats.hand)
	bug_icon.texture = player_1_stats.hand[0].bug_resource.icon
	element_icon.texture = player_1_stats.hand[0].element_resource.icon
	psyche_icon.texture = player_1_stats.hand[0].psyche_resource.icon

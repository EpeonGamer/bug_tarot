extends Node2D

@onready var bug_icon: TextureRect = %bug_icon
@onready var element_icon: TextureRect = %element_icon
@onready var psyche_icon: TextureRect = %psyche_icon


#region Preload Icons (REPLACE)
# replace when card resource is complete
var b_icon_all := []
var b_icon_wasp := preload("res://icons/bug_icons/wasp_progart.png")
var b_icon_mantis := preload("res://icons/bug_icons/mantis_progart.png")
var b_icon_roach := preload("res://icons/bug_icons/roach_progart.png")
var b_icon_beetle := preload("res://icons/bug_icons/beetle_progart.png")
var b_icon_worm := preload("res://icons/bug_icons/worm_progart.png")
var b_icon_butterfly := preload("res://icons/bug_icons/butterfly_progart.png")
var b_icon_earwig := preload("res://icons/bug_icons/earwig_progart.png")
var b_icon_fly := preload("res://icons/bug_icons/fly_progart.png")
var b_icon_grub := preload("res://icons/bug_icons/grub_progart.png")
var b_icon_pillbug := preload("res://icons/bug_icons/pillbug_progart.png")
var b_icon_spider := preload("res://icons/bug_icons/spider_progart.png")
var b_icon_snail := preload("res://icons/bug_icons/snail_progart.png")
var b_icon_ant := preload("res://icons/bug_icons/ant_progart.png")
var b_icon_centipede := preload("res://icons/bug_icons/centipede_progart.png")
var b_icon_locust := preload("res://icons/bug_icons/locust_progart.png")
var b_icon_mosquito := preload("res://icons/bug_icons/mosquito_progart.png")
var b_icon_moth := preload("res://icons/bug_icons/moth_progart.png")

var e_icon_all := []
var e_icon_barrier := preload("res://icons/element_icons/barrier_progart.png")
var e_icon_fire := preload("res://icons/element_icons/fire_progart.png")
var e_icon_illusion := preload("res://icons/element_icons/illusion_progart.png")
var e_icon_swarm := preload("res://icons/element_icons/swarm_progart.png")

var p_icon_all := []
var p_icon_servant := preload("res://icons/psych_icons/servant_progart.png")
var p_icon_sloth := preload("res://icons/psych_icons/sloth_progart.png")
var p_icon_wrath := preload("res://icons/psych_icons/wrath_progart.png")
#endregion

var scroll_index : int = 0
var scroll_subindex_e : int = 0
var scroll_subindex_p : int = 0

func _ready() -> void:
	randomize()
	#bugs
	b_icon_all.append(b_icon_wasp)
	b_icon_all.append(b_icon_mantis)
	b_icon_all.append(b_icon_roach)
	b_icon_all.append(b_icon_beetle)
	b_icon_all.append(b_icon_worm)
	b_icon_all.append(b_icon_butterfly)
	b_icon_all.append(b_icon_earwig)
	b_icon_all.append(b_icon_fly)
	b_icon_all.append(b_icon_grub)
	b_icon_all.append(b_icon_pillbug)
	b_icon_all.append(b_icon_spider)
	b_icon_all.append(b_icon_snail)
	b_icon_all.append(b_icon_ant)
	b_icon_all.append(b_icon_centipede)
	b_icon_all.append(b_icon_locust)
	b_icon_all.append(b_icon_mosquito)
	b_icon_all.append(b_icon_moth)
	#elements
	e_icon_all.append(e_icon_barrier)
	e_icon_all.append(e_icon_fire)
	e_icon_all.append(e_icon_illusion)
	e_icon_all.append(e_icon_swarm)
	#psyches
	p_icon_all.append(p_icon_servant)
	p_icon_all.append(p_icon_sloth)
	p_icon_all.append(p_icon_wrath)
	load_icons()
	

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		load_icons()
		
	#scroll bugs
	if Input.is_action_just_pressed("ui_right"):
		scroll_index += 1
		if scroll_index >= b_icon_all.size():
			scroll_index = 0
		load_icons(scroll_index,scroll_subindex_e,scroll_subindex_p)
	if Input.is_action_just_pressed("ui_left"):
		scroll_index -= 1
		if scroll_index <= -1:
			scroll_index = b_icon_all.size() - 1
		load_icons(scroll_index,scroll_subindex_e,scroll_subindex_p)
			
	#scroll elements
	if Input.is_action_just_pressed("ui_up"):
		scroll_subindex_e += 1
		if scroll_subindex_e >= e_icon_all.size():
			scroll_subindex_e = 0
		load_icons(scroll_index,scroll_subindex_e,scroll_subindex_p)
	if Input.is_action_just_pressed("ui_down"):
		scroll_subindex_e -= 1
		if scroll_subindex_e <= -1:
			scroll_subindex_e = e_icon_all.size() - 1
		load_icons(scroll_index,scroll_subindex_e,scroll_subindex_p)
			
	#scroll_psyches
	if Input.is_action_just_pressed("ui_page_up"):
		scroll_subindex_p += 1
		if scroll_subindex_p >= p_icon_all.size():
			scroll_subindex_p = 0
		load_icons(scroll_index,scroll_subindex_e,scroll_subindex_p)
	if Input.is_action_just_pressed("ui_page_down"):
		scroll_subindex_p -= 1
		if scroll_subindex_p <= -1:
			scroll_subindex_p = p_icon_all.size() - 1
		load_icons(scroll_index,scroll_subindex_e,scroll_subindex_p)
	
	#cycle all variations
	if Input.is_action_just_pressed("ui_focus_next"):
		set_process_input(false)
		var counter : int = 0
		for i in b_icon_all:
			for j in e_icon_all:
				for k in p_icon_all:
					bug_icon.texture = i
					element_icon.texture = j
					psyche_icon.texture = k
					counter += 1
					await get_tree().create_timer(0.1).timeout
		print("Total variations: " + str(counter))
		set_process_input(true)
	
	#get screenshot
	if Input.is_action_just_pressed("ui_copy"):
		var capture = get_viewport().get_texture().get_image()
		var _time = Time.get_datetime_string_from_system()
		_time = _time.replace(":", "-")
		var filename = "res://Screenshots/Screenshot-{0}.png".format({"0":_time})
		capture.save_png(filename)
		print("screenshot")

func load_icons(b_index : int = -1, e_index : int = -1, p_index : int = -1) -> void:
	# make sequential
	if b_index < 0:
		var bug_choice : int = randi_range(0,b_icon_all.size() - 1)
		bug_icon.texture = b_icon_all[bug_choice]
	else:
		bug_icon.texture = b_icon_all[b_index]
	if e_index < 0:
		var element_choice : int = randi_range(0,e_icon_all.size() - 1)
		element_icon.texture = e_icon_all[element_choice]
	else:
		element_icon.texture = e_icon_all[e_index]
	if p_index < 0:
		var psyche_choice : int = randi_range(0,p_icon_all.size() - 1)
		psyche_icon.texture = p_icon_all[psyche_choice]
	else:
		psyche_icon.texture = p_icon_all[p_index]

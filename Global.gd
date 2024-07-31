extends Node

var character_position = Vector2(65,-150)
var respawn_pos = Vector2(65,-150)
var current_animation
var facing
#var current_level = 1
var max_life = 4
var current_life_total = 4
var topviewporty = 1152

var light_up = false

func change_level(new_level, shadow_exit, portal_spawn):
	call_deferred("_deferred_change_level", new_level, shadow_exit, portal_spawn)

func _deferred_change_level(new_level, shadow_exit, portal_spawn):
	var subviewport = get_node("/root/GameScene/VBoxContainer/TopViewportContainer/TopViewport")
	subviewport.get_child(0).queue_free()
	var next_scene = load(new_level)
	character_position = portal_spawn
	respawn_pos = portal_spawn
	subviewport.add_child(next_scene.instantiate())
	
	var shadow_subviewport = get_node("/root/GameScene/VBoxContainer/BottomViewportContainer/BottomViewport")
	shadow_subviewport.get_child(0).queue_free()
	var sh_next_scene = load(shadow_exit)
	shadow_subviewport.add_child(sh_next_scene.instantiate())

func damage():
	current_life_total -= 1

func obtain_health():
	max_life += 1
	current_life_total = max_life

func update_topviewport():
	var topview = get_node("/root/GameScene/VBoxContainer/TopViewportContainer/TopViewport")
	topview.size.y = topviewporty

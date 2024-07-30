extends Node

var character_position
var current_animation
var facing
#var current_level = 1
var max_life = 4
var current_life_total = 4

#func change_level():
	#var current_level_path = "/root/GameScene/VBoxContainer/TopViewportContainer/TopViewport/CurrentLevel"
	#var next_path = load(str("res://World/Levels/level", current_level + 1, ".tscn"))
	#var instance = next_path.instantiate()
	#instance.name = "CurrentLevel"
	#get_node("/root/GameScene/VBoxContainer/TopViewportContainer/TopViewport").add_child(instance)
	#get_node(current_level_path).queue_free()
	#current_level += 1

func damage():
	current_life_total -= 1

func obtain_health():
	max_life += 1

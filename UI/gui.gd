extends Node2D

var max_life = 4
var current_life_total = 4


func _on_character_damage_taken():
	current_life_total -= 1
	$CanvasLayer/HBoxContainer.get_child(current_life_total).visible = false
	$CanvasLayer/Darkness.visible = false
	$LightTimer.start()



func _on_shadow_damage_taken():
	current_life_total -= 1
	$CanvasLayer/HBoxContainer.get_child(current_life_total).visible = false
	$CanvasLayer/Darkness.visible = false
	$LightTimer.start()



func _on_light_timer_timeout():
	$CanvasLayer/Darkness.visible = true

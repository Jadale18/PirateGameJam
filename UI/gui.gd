extends Node2D

var max_life = 10
var current_life_total = 10

func _process(delta):
	if current_life_total == 0:
		print('game over')
		queue_free()

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

extends Area2D

signal button_down

func _on_area_entered(area):
	$Sprite2D.visible = true
	$Sprite2D2.visible = false
	emit_signal("button_down")


func _on_area_exited(area):
	$Sprite2D.visible = false
	$Sprite2D2.visible = true

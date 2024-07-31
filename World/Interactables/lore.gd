extends Area2D

signal loretime

func _on_area_entered(area):
	if area.name == "CharArea":
		emit_signal("loretime")

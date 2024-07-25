extends Node2D

func _on_finish_area_entered(area):
	if area.name == "CharArea":
		Global.change_level()

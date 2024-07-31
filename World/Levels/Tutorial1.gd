extends Node2D

func _ready():
	if Global.escaping:
		$Lore2.visible = true
		$Lore2.monitoring = true

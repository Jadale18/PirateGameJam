extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.health_upgrades[0] == 1:
		$Background/OffOrb.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.health_upgrades[0] == 1 and $Background/Off:
		$Background/OffOrb.queue_free()

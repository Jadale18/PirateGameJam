extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.health_upgrades[4] == 1:
		$Background/OffOrb.queue_free()
	if Global.dumb_doors[7] == 1:
		$Door7.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.health_upgrades[1] == 1:
		$Background/OffOrb.queue_free()
	if Global.dumb_doors[1] == 1:
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

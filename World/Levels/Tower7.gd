extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.health_upgrades[6] == 1:
		$Background/OffOrb.queue_free()
	if Global.dumb_doors[9] == 1:
		$Door9.queue_free()
	if Global.dumb_doors[10] == 1:
		$Door10.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

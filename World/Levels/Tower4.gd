extends Node2D

var doors = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.health_upgrades[3] == 1:
		$Background/OffOrb.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
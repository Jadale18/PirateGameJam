extends Node2D

var doors = []
var solution = ["Iron", "Copper", "Fire"]
var current_sol = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.health_upgrades[3] == 1:
		$Background/OffOrb.queue_free()
	if Global.dumb_doors[5] == 1:
		$Door5.queue_free()
	if Global.dumb_doors[6] == 1:
		$Door6.queue_free()
	if Global.puzzle_door:
		$PuzzleDoor.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(current_sol) == 3:
		if current_sol[0] in solution and current_sol[1] in solution and current_sol[2] in solution:
			$Success.play()
			if Global.puzzle_door == false:
				Global.puzzle_door = true
			$PuzzleDoor.queue_free()
		else:
			$Fail.play()
		current_sol = []
		$EarthTablet.reset()
		$FireTablet.reset()
		$AirTablet.reset()
		$WaterTablet.reset()
		$CopperTablet.reset()
		$JupiterTablet.reset()
		$MercuryTablet.reset()
		$IronTablet.reset()

func _on_iron_tablet_activated():
	current_sol.append("Iron")


func _on_jupiter_tablet_activated():
	current_sol.append("Silver")


func _on_mercury_tablet_activated():
	current_sol.append("Mercury")


func _on_copper_tablet_activated():
	current_sol.append("Copper")


func _on_fire_tablet_activated():
	current_sol.append("Fire")


func _on_water_tablet_activated():
	current_sol.append("Water")


func _on_earth_tablet_activated():
	current_sol.append("Earth")


func _on_air_tablet_activated():
	current_sol.append("Air")

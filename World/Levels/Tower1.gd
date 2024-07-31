extends Node2D

var sols_found = 0
var m_solution = ["Water", "Air"]
var salt_solution = ["Water", "Earth"]
var sulf_solution = ["Air", "Fire"]
var current_sol = []


func _ready():
	if Global.health_upgrades[0] == 1 and $Background/OffOrb:
		$Background/OffOrb.queue_free()
	if Global.dumb_doors[0] == 1:
		sols_found = 3
	if Global.dumb_doors[1] == 1:
		$T3Door.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(current_sol) == 2:
		if current_sol[0] in m_solution and current_sol[1] in m_solution:
			merc()
			$Success.play()
		elif current_sol[0] in salt_solution and current_sol[1] in salt_solution:
			salt()
			$Success.play()
		elif current_sol[0] in sulf_solution and current_sol[1] in sulf_solution:
			sulf()
			$Success.play()
		else:
			$Fail.play()
		current_sol = []
		$Tablets/EarthTablet.reset()
		$Tablets/FireTablet.reset()
		$Tablets/AirTablet.reset()
		$Tablets/WaterTablet.reset()
	
	if sols_found == 3:
		if Global.dumb_doors[0] != 1:
			Global.dumb_doors[0] = 1
		$T2Door.queue_free()
		sols_found = 0

func _on_earth_tablet_activated():
	current_sol.append("Earth")
	
func _on_air_tablet_activated():
	current_sol.append("Air")

func _on_water_tablet_activated():
	current_sol.append("Water")

func _on_fire_tablet_activated():
	current_sol.append("Fire")

func merc():
	$Cutscene/AnimationPlayer.play("FadeOut")
	m_solution = []
	sols_found += 1
	$Tablets/MercuryKeyTabletOrbDeactivatedRoom1.visible = false

func salt():
	$HealthUpgrade.visible = true
	$HealthUpgrade.monitoring = true
	salt_solution = []
	sols_found += 1
	$Tablets/SaltKeyTabletOrbDeactivatedRoom1.visible = false
	$Background/OffOrb.queue_free()

func sulf():
	sulf_solution = []
	sols_found += 1
	$Tablets/SulfurKeyTabletOrbDeactivatedRoom1.visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "FadeOut":
		$Cutscene/AnimationPlayer.play("Mercury1")
		$Character/AnimatedSprite2D.visible = true
		$Character/AnimatedSprite2D.play("shadowflood")
	elif anim_name == "Mercury1":
		Global.topviewporty = 800
		Global.update_topviewport()
		$Cutscene/AnimationPlayer.play("Mercury2")
	elif anim_name == "Mercury2":
		Global.topviewporty = 576
		Global.update_topviewport()
		$Cutscene/AnimationPlayer.play("Mercury3")
		$Character/AnimatedSprite2D.visible = false
		$Character/Anims.play("Idle")
		$Character.animating = false
		$Character.checking_input = true
		


extends Node2D


var m_solution = ["Water", "Air"]
var salt_solution = ["Water", "Earth"]
var sulf_solution = ["Air", "Fire"]
var current_sol = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.health_upgrades[0] == 1 and $Background/OffOrb:
		$Background/OffOrb.queue_free()

	if len(current_sol) == 2:
		if current_sol[0] in m_solution and current_sol[1] in m_solution:
			merc()
		elif current_sol[0] in salt_solution and current_sol[1] in salt_solution:
			salt()
		elif current_sol[0] in sulf_solution and current_sol[1] in sulf_solution:
			sulf()
		current_sol = []
		$Tablets/EarthTablet.reset()
		$Tablets/FireTablet.reset()
		$Tablets/AirTablet.reset()
		$Tablets/WaterTablet.reset()


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
	$Tablets/MercuryKeyTabletOrbDeactivatedRoom1.visible = false

func salt():
	$HealthUpgrade.visible = true
	$HealthUpgrade.monitoring = true
	salt_solution = []
	$Tablets/SaltKeyTabletOrbDeactivatedRoom1.visible = false

func sulf():
	$T2Door.queue_free()
	sulf_solution = []
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
		

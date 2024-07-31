extends Node2D

func merc():
	$Cutscene/AnimationPlayer.play("FadeOut")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "FadeOut":
		$Cutscene/AnimationPlayer.play("Mercury1")
		$Character/AnimatedSprite2D.visible = true
		$Character/AnimatedSprite2D.play_backwards("shadowflood")
	elif anim_name == "Mercury1":
		Global.topviewporty = 800
		Global.update_topviewport()
		$Cutscene/AnimationPlayer.play("Mercury2")
	elif anim_name == "Mercury2":
		Global.topviewporty = 1152
		Global.update_topviewport()
		$Cutscene/AnimationPlayer.play("Mercury3")
		$Character/AnimatedSprite2D.visible = false
		$Character/Anims.play("Idle")
		$Character.animating = false
		$Character.checking_input = true
		Global.escaping = true


func _on_finish_area_entered(area):
	merc()

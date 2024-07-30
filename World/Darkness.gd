extends CanvasLayer

func _process(delta):
	if Global.light_up:
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("lightup")
		Global.light_up = false

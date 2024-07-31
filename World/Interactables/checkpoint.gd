extends Area2D

var checking_input = false
var healed = false

func _process(delta):
	if checking_input and Input.is_action_just_pressed("Interact"):
		$CPUParticles2D.emitting = true
		$CPUParticles2D2.emitting = true
		checking_input = false
		$RichTextLabel.visible = false
		$AnimationPlayer.play("activate")
		Global.respawn_pos = global_position
		$AudioStreamPlayer.play()
		if not healed:
			Global.current_life_total = Global.max_life
			healed = true
			$CPUParticles2D3.emitting = false

func _on_area_entered(area):
	if area.name == "CharArea":
		checking_input = true
		$RichTextLabel.visible = true


func _on_area_exited(area):
	checking_input = false
	$RichTextLabel.visible = false

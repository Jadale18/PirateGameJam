extends Area2D

var checking_input = false
@export_range(0,7,1) var tower_num = 0

func _ready():
	if Global.health_upgrades[tower_num] == 1:
		queue_free()
	$HealthAnims.play("Idle")
	$AnimationPlayer.play("Idle")

func _process(delta):
	if checking_input and Input.is_action_just_pressed("Interact"):
		Global.obtain_health()
		Global.health_upgrades[tower_num] = 1
		$HealthAnims.play("Damage")
		$RichTextLabel.visible = false
		$CPUParticles2D.emitting = false
		$AudioStreamPlayer.play()
		$Timer.start()


func _on_area_entered(area):
	checking_input = true
	$RichTextLabel.visible = true



func _on_area_exited(area):
	checking_input = false
	$RichTextLabel.visible = false


func _on_timer_timeout():
	queue_free()

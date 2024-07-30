extends Area2D

var checking_input = false

func _ready():
	$HealthAnims.play("Idle")
	$AnimationPlayer.play("Idle")

func _process(delta):
	if checking_input and Input.is_action_just_pressed("Interact"):
		Global.obtain_health()
		$HealthAnims.play("Damage")
		$RichTextLabel.visible = false


func _on_area_entered(area):
	checking_input = true
	$RichTextLabel.visible = true


func _on_health_anims_animation_finished():
	queue_free()


func _on_area_exited(area):
	checking_input = false
	$RichTextLabel.visible = false

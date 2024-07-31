extends Area2D

signal loretime(num)
var checking_input = false
var checked = false
@export var num = 0

func _ready():
	$AnimationPlayer.play("idle")

func _process(delta):
	if checking_input and Input.is_action_just_pressed("Interact"):
		if not checked:
			$AnimationPlayer.play("fall")
			checked = true
			$AudioStreamPlayer.play()
		checking_input = false
		$RichTextLabel.visible = false
		emit_signal("loretime", num)

func _on_area_entered(area):
	if area.name == "CharArea":
		checking_input = true
		$RichTextLabel.visible = true




func _on_area_exited(area):
	checking_input = false
	$RichTextLabel.visible = false

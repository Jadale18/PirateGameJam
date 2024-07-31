extends Area2D

signal activated
var checking_input = false
var active = false

func _process(delta):
	if checking_input and Input.is_action_just_pressed("Interact"):
		$CopperTabletInteractable.modulate = Color(2,2,2,1)
		active = true
		checking_input = false
		emit_signal("activated")

func _on_area_entered(area):
	if not active:
		checking_input = true
		$CopperTabletInteractable.modulate = Color(0.7,0.7,0.7,1)


func _on_area_exited(area):
	if not active:
		checking_input = false
		$CopperTabletInteractable.modulate = Color(1,1,1,1)

func reset():
	active = false
	$CopperTabletInteractable.modulate = Color(1,1,1,1)

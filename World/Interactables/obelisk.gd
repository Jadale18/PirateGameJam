extends Area2D

signal activated
var checking_input
var active

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if checking_input and Input.is_action_just_pressed("Interact"):
		$ObeliskInteractable.modulate = Color(2,2,2,1)
		active = true
		checking_input = false
		emit_signal("activated")


func _on_area_entered(area):
	if not active:
		checking_input = true
		$ObeliskInteractable.modulate = Color(0.7,0.7,0.7,1)


func _on_area_exited(area):
	if not active:
		checking_input = false
		$ObeliskInteractable.modulate = Color(1,1,1,1)

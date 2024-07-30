extends Control

var pausable = true
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("Pause") and pausable and not paused:
		visible = true
		get_tree().paused = true
		pausable = false
		paused = true
	elif Input.is_action_just_pressed("Pause") and paused:
		visible = false
		get_tree().paused = false
		pausable = true
		paused = false

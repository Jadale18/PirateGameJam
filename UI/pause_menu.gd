extends Control

var pausable = false

func _process(delta):
	if Input.is_action_just_pressed("Pause") and pausable:
		visible = true
		get_tree().paused = true
		pausable = false

func _on_resume_pressed():
		visible = false
		get_tree().paused = false
		pausable = true


func _on_settings_pressed():
	print('settings')


func _on_quit_pressed():
	print('quit to menu')

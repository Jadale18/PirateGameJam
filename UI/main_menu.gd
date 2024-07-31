extends Control

func _ready():
	$AnimationPlayer.play("Idle")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://World/test_split.tscn")
	PauseMenu.pausable = true


func _on_settings_pressed():
	print("settings time")


func _on_quit_pressed():
	get_tree().quit()

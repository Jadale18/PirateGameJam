extends Control

func _ready():
	$AnimationPlayer.play("Idle")
	MainMusic.stop_music()
	MainMusic.play_atoweringtale()

func _on_start_pressed():
	$AnimationPlayer.play("Fade")
	PauseMenu.pausable = true
	


func _on_settings_pressed():
	print("settings time")


func _on_quit_pressed():
	get_tree().quit()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Fade":
		get_tree().change_scene_to_file("res://World/GameScene.tscn")

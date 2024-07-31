extends Node2D

func play_dawn():
	$Dawn.play()

func play_noonshadow():
	$NoonShadow.play()

func stop_music():
	$Dawn.stop()
	$NoonShadow.stop()

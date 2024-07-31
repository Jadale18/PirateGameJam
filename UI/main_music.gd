extends Node2D

func play_dawn():
	$Dawn.play()

func play_noonshadow():
	$NoonShadow.play()

func play_atoweringtale():
	$AToweringTale.play()

func play_roomtransition():
	$RoomTransition.play()

func stop_music():
	$Dawn.stop()
	$NoonShadow.stop()
	$AToweringTale.stop()

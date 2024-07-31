extends Node2D


func _on_timer_timeout():
	if $CanvasLayer/RichTextLabel.visible_ratio != 1:
		$CanvasLayer/RichTextLabel.visible_characters += 1
		$CanvasLayer/Timer.start()
	else:
		$WaitTimer.start()


func _on_lore_loretime():
	$CanvasLayer/RichTextLabel.visible_characters = 0
	$CanvasLayer.visible = true
	$CanvasLayer/Timer.start()


func _on_wait_timer_timeout():
	$CanvasLayer/RichTextLabel.visible_characters = 0
	$CanvasLayer.visible = false

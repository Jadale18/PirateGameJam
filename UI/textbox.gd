extends Node2D


func _on_timer_timeout():
	if $CanvasLayer/MarginContainer/MarginContainer/RichTextLabel.visible_ratio != 1:
		$CanvasLayer/MarginContainer/MarginContainer/RichTextLabel.visible_characters += 1
		$CanvasLayer/Timer.start()
	else:
		$WaitTimer.start()


func _on_lore_loretime():
	$CanvasLayer/MarginContainer/MarginContainer/RichTextLabel.visible_characters = 0
	$CanvasLayer/MarginContainer.visible = true
	$CanvasLayer/Timer.start()


func _on_wait_timer_timeout():
	$CanvasLayer/MarginContainer/MarginContainer/RichTextLabel.visible_characters = 0
	$CanvasLayer/MarginContainer.visible = false

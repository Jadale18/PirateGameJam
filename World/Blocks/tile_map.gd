extends TileMap



func _on_door_2_button_button_down():
	if Global.dumb_doors[2] != 1:
		Global.dumb_doors[2] = 1
	queue_free()


func _on_door_3_button_button_down():
	if Global.dumb_doors[3] != 1:
		Global.dumb_doors[3] = 1
	queue_free()

func _on_door_4_button_button_down():
	if Global.dumb_doors[4] != 1:
		Global.dumb_doors[4] = 1
	queue_free()

func _on_door_5_button_button_down():
	if Global.dumb_doors[5] != 1:
		Global.dumb_doors[5] = 1
	queue_free()


func _on_door_6_button_button_down():
	if Global.dumb_doors[6] != 1:
		Global.dumb_doors[6] = 1
	queue_free()


func _on_door_7_button_button_down():
	if Global.dumb_doors[7] != 1:
		Global.dumb_doors[7] = 1
	queue_free()


func _on_door_8_button_button_down():
	if Global.dumb_doors[8] != 1:
		Global.dumb_doors[8] = 1
	queue_free()


func _on_door_9_button_button_down():
	if Global.dumb_doors[9] != 1:
		Global.dumb_doors[9] = 1
	queue_free()


func _on_door_10_button_button_down():
	if Global.dumb_doors[10] != 1:
		Global.dumb_doors[10] = 1
	queue_free()


func _on_door_button_button_down():
	if Global.tut2_door != 1:
		Global.tut2_door = 1
	queue_free()

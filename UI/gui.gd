extends Node2D

var max_life = 4
var current_life_total = 4

func _ready():
	for child in $CanvasLayer/HBoxContainer.get_children():
		child.get_child(0).play("Empty")
		child.get_child(1).play("Idle")

func _process(delta):
	if current_life_total == 0:
		pass
	if Global.current_life_total == current_life_total - 1:
		damage_taken()

func damage_taken():
	current_life_total -= 1
	$CanvasLayer/HBoxContainer.get_child(current_life_total).get_child(1).play("Damage")







func _on_shadow_damage_taken():
	current_life_total -= 1
	$CanvasLayer/HBoxContainer.get_child(current_life_total).visible = false




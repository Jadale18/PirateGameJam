extends CharacterBody2D

signal damage_taken

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@export_range(-1, 1, 2) var gravity_multiplier = 1
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_multiplier


func _physics_process(delta):
	if global_position.y != Global.character_position.y * -1:
		global_position.y = Global.character_position.y * -1
	if global_position.x != Global.character_position.x:
		global_position.x = Global.character_position.x
	
	move_and_slide()

func take_damage():
	emit_signal("damage_taken")


func _on_area_2d_area_entered(area):
	take_damage()

extends CharacterBody2D

signal damage_taken

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@export_range(-1, 1, 2) var gravity_multiplier = 1
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_multiplier


func _physics_process(delta):
	if not is_on_ceiling():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or is_on_ceiling()):
		velocity.y = JUMP_VELOCITY * gravity_multiplier

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func take_damage():
	print('dmg')
	emit_signal("damage_taken")


func _on_area_2d_area_entered(area):
	take_damage()

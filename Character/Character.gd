extends CharacterBody2D

var max_life = 4
var current_life_total = 4

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@export_range(-1, 1, 2) var gravity_multiplier = 1
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_multiplier


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or is_on_ceiling()):
		velocity.y = JUMP_VELOCITY * gravity_multiplier

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	take_damage()
	check_gameover()

func take_damage():
	if Input.is_action_just_pressed("Take Damage"):
		print('dmg')
		current_life_total -= 1
		$CanvasLayer/HBoxContainer.get_child(current_life_total).visible = false

func check_gameover():
	if current_life_total == 0:
		print('game over')
		queue_free()


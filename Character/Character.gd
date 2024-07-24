extends CharacterBody2D

signal damage_taken

const SPEED = 400.0
const JUMP_VELOCITY = -800.0
var current_life = 10

@export_range(-1, 1, 2) var gravity_multiplier = 1
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_multiplier
var animating = false

func _ready():
	$Anims.play("Idle")

func _physics_process(delta):
	if not animating:
		handle_anims()
	if not is_on_floor():
		velocity.y += gravity * delta
	if current_life == 0:
		$Anims.play("Death")

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or is_on_ceiling()):
		velocity.y = JUMP_VELOCITY * gravity_multiplier

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			$Anims.flip_h = true
		else:
			$Anims.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("Take Damage"):
		animating = true
		$Anims.play("Self_Damage")
		take_damage()
	
	Global.character_position = global_position

func take_damage():
	emit_signal("damage_taken")
	current_life -= 1

func _on_area_2d_area_entered(area):
	if "Spike" in area.name:
		animating = true
		$Anims.play("Damaged")
		take_damage()

func handle_anims():
	if is_on_floor() and velocity.x != 0:
		$Anims.play("Run")
	elif is_on_floor() and velocity.x == 0:
		$Anims.play("Idle")
	if Input.is_action_just_pressed("ui_accept"):
		$Anims.play("Jump")




func _on_anims_animation_looped():
	if $Anims.animation == "Jump":
		$Anims.play("Air_Look_Down")
	elif $Anims.animation == "Air_Look_Down":
		$Anims.play("Air_Idle")
	elif $Anims.animation in ["Damaged", "Self_Damage"]:
		animating = false

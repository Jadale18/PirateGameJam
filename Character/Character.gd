extends CharacterBody2D

signal damage_taken

const SPEED = 600.0
const JUMP_VELOCITY = -1000.0
var current_life = 10

@export_range(-1, 1, 2) var gravity_multiplier = 1
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_multiplier
var animating = false
var falling = false
var landing = false
var jumping = false
var dead = false
var checking_input = true

func _ready():
	$Anims.play("Idle")

func _physics_process(delta):
	if not animating:
		handle_anims()
	if not is_on_floor():
		velocity.y += gravity * delta
	if current_life == 0 and not dead:
		$Anims.play("Death")
		dead = true
		checking_input = false
	if is_on_floor() and falling and not animating and not jumping:
		landing = true
		$Anims.play("Land")
		falling = false

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and checking_input:
		velocity.y = JUMP_VELOCITY * gravity_multiplier

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and checking_input:
		velocity.x = direction * SPEED
		if direction < 0:
			$Anims.flip_h = true
		else:
			$Anims.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("Take Damage") and is_on_floor() and checking_input:
		animating = true
		$Anims.play("Self_Damage")
		checking_input = false
		take_damage()
	
	Global.character_position = global_position

func take_damage():
	emit_signal("damage_taken")
	current_life -= 1

func _on_area_2d_area_entered(area):
	if "Spike" in area.name:
		animating = true
		$Anims.play("Damaged")
		checking_input = false
		take_damage()

func handle_anims():
	if is_on_floor() and velocity.x != 0:
		$Anims.play("Run")
		landing = false
	elif is_on_floor() and velocity.x == 0 and not landing:
		$Anims.play("Idle")
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$Anims.play("Jump")
		landing = false
		jumping = true

func _on_anims_animation_finished():
	if $Anims.animation == "Jump":
		$Anims.play("Air_Look_Down")
		jumping = false
		falling = true
	elif $Anims.animation == "Air_Look_Down":
		$Anims.play("Air_Idle")
	elif $Anims.animation == "Land":
		landing = false
	elif $Anims.animation in ["Damaged", "Self_Damage"]:
		animating = false
		checking_input = true
		if is_on_floor():
			falling = false


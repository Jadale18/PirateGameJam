extends CharacterBody2D

signal damage_taken

const SPEED = 400.0
const JUMP_VELOCITY = -800.0
var current_life = 10

@export_range(-1, 1, 2) var gravity_multiplier = 1
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_multiplier
var animating = false
var falling = false
var landing = false
var jumping = false
var dead = false
var on_ledge = false
var detecting_ledge = true
var checking_input = true
var gravity_on = true
var hit_point_1
var hit_point_2
var climbing = false

func _ready():
	$Anims.play("Idle")

func _physics_process(delta):
	if not animating:
		handle_anims()
	if not is_on_floor() and gravity_on:
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
	ledge_detect()
	
	if Input.is_action_just_pressed("Take Damage") and is_on_floor() and checking_input:
		animating = true
		$Anims.play("Self_Damage")
		checking_input = false
		take_damage()
	
	if on_ledge:
		ledge_grab()
		if Input.is_action_just_pressed("ui_accept"):
			climbing = true
			$Anims.play("Edge_Up")
			on_ledge = false
			$LedgeBuffer.start()
	if climbing:
		global_position.x = move_toward(global_position.x, hit_point_1.x + 30, 3)
		global_position.y = move_toward(global_position.y, hit_point_2.y - 53, 4)
			
	
	Global.character_position = global_position

func take_damage():
	emit_signal("damage_taken")
	current_life -= 1

func ledge_detect():
	hit_point_1 = $LedgeChecker.get_collision_point()
	hit_point_2 = $Head.get_collision_point()
	if $LedgeChecker.is_colliding() and not $SpaceChecker.is_colliding() and not on_ledge and detecting_ledge:
		$Anims.play("Grab_Edge")
		detecting_ledge = false
		gravity_on = false
		checking_input = false
		velocity.y = 0
		on_ledge = true

func ledge_grab():
	global_position.x = move_toward(global_position.x, hit_point_1.x - 50, 5)
	global_position.y = move_toward(global_position.y, hit_point_2.y + 45, 5)

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
	elif is_on_floor() and velocity.x == 0 and not landing and not climbing:
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
	elif $Anims.animation == "Edge_Up":
		checking_input = true
		gravity_on = true
		climbing = false
	elif $Anims.animation in ["Damaged", "Self_Damage"]:
		animating = false
		checking_input = true
		if is_on_floor():
			falling = false
	



func _on_ledge_buffer_timeout():
	detecting_ledge = true

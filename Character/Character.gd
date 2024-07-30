extends CharacterBody2D

signal damage_taken

const SPEED = 200.0
const JUMP_VELOCITY = -575.0
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
var facing_left = -1
var last_floor = true
var jump_buffer = false

func _ready():
	$Anims.play("Idle")

func _physics_process(delta):
	if $Anims.animation != "Jump":
		jumping = false
	coyote()
	if not animating:
		handle_anims()
	if not is_on_floor() and gravity_on:
		velocity.y += gravity * delta
	if current_life == 0 and not dead:
		$Anims.play("Death")
		dead = true
		checking_input = false
	if is_on_floor() and falling and not animating and not jumping and not climbing:
		landing = true
		$Anims.play("Land")
		falling = false
		jumping = false
	if is_on_floor() and jump_buffer:
		velocity.y = JUMP_VELOCITY * gravity_multiplier
		jumping = true
		falling = true
		jump_buffer = false

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or not $CoyoteTime.is_stopped()) and checking_input:
		velocity.y = JUMP_VELOCITY * gravity_multiplier
		jumping = true
		falling = true
		jump_buffer = false
	elif Input.is_action_just_pressed("ui_accept"):
		jump_buffer = true
		$JumpBuffer.start()

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and checking_input:
		velocity.x = direction * SPEED
		if direction < 0:
			$Anims.flip_h = true
			$LedgeChecker.target_position.x = -150
			$Head.position.x = -150
			$SpaceChecker.target_position.x = -150
			facing_left = -1
		else:
			$Anims.flip_h = false
			$LedgeChecker.target_position.x = 150
			$Head.position.x = 150
			$SpaceChecker.target_position.x = 150
			facing_left = 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	ledge_detect()
	
	if Input.is_action_just_pressed("Take Damage") and is_on_floor() and checking_input:
		animating = true
		$Anims.play("Self_Damage")
		checking_input = false
		take_damage()
		
	if Input.is_action_just_pressed("Interact") and is_on_floor() and checking_input:
		animating = true
		$Anims.play('Interact')
		checking_input = false
	
	if on_ledge:
		ledge_grab()
		var climb_inpu
		var drop_inpu
		if facing_left == -1:
			climb_inpu = "ui_left"
			drop_inpu = "ui_right"
		else:
			climb_inpu = "ui_right"
			drop_inpu = "ui_left"
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed(climb_inpu):
			climbing = true
			$Anims.play("Edge_Up")
			on_ledge = false
			$LedgeBuffer.start()
		elif Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed(drop_inpu):
			on_ledge = false
			$LedgeBuffer.start()
			$Anims.play("Air_Look_Down")
			checking_input = true
			gravity_on = true
	if climbing:
		global_position.x = move_toward(global_position.x, hit_point_1.x + (15 * facing_left), 5)
		global_position.y = move_toward(global_position.y, hit_point_2.y - 26.5, 5)
	
	
	Global.current_animation = $Anims.animation
	Global.character_position = global_position
	Global.facing = facing_left

func take_damage():
	emit_signal("damage_taken")
	current_life -= 1

func ledge_detect():
	hit_point_1 = $LedgeChecker.get_collision_point()
	hit_point_2 = $Head.get_collision_point()
	if $LedgeChecker.is_colliding() and not $SpaceChecker.is_colliding() and not on_ledge and detecting_ledge and not is_on_floor():
		if $LedgeChecker.get_collider().name != "DropTiles":
			$Anims.play("Grab_Edge")
			detecting_ledge = false
			gravity_on = false
			checking_input = false
			velocity.y = 0
			on_ledge = true
			falling = false

func ledge_grab():
	global_position.x = move_toward(global_position.x, hit_point_1.x - (25 * facing_left), 2.5)
	global_position.y = move_toward(global_position.y, hit_point_2.y + 22.5, 2.5)

func coyote():
	if not is_on_floor() and last_floor and not climbing and not jumping:
		$Anims.play("Air_Look_Down")
		falling = true
		$CoyoteTime.start()
	last_floor = is_on_floor()

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
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not climbing:
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
	elif $Anims.animation in ["Damaged", "Self_Damage", "Interact"]:
		animating = false
		checking_input = true
		if is_on_floor():
			falling = false

func _on_ledge_buffer_timeout():
	detecting_ledge = true
	
func _input(event : InputEvent):
	if (event.is_action_pressed("ui_down")) and is_on_floor():
		collision_mask = 1
		$DropBuffer.start()

func _on_drop_buffer_timeout():
	collision_mask = 3

func _on_jump_buffer_timeout():
	jump_buffer = false

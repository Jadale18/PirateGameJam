extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -575.0
var current_life = 4

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
var foot = "right"
var invincible = false
var escaping = false
var eclipsed = false

func _ready():
	$Anims.play("Idle")
	add_to_group("Player")
	position = Global.character_position

func _physics_process(delta):
	if Global.escaping and not eclipsed:
		$Anims.queue_free()
		$Anims.name = "A"
		$CombinedAnims.visible = true
		$CombinedAnims.name = "Anims"
		eclipsed = true
	if $Anims.animation != "Jump":
		jumping = false
	coyote()
	if not animating:
		handle_anims()
	if not is_on_floor() and gravity_on:
		velocity.y += gravity * delta
		$WalkTimer.stop()
	if current_life == 0 and not dead:
		$Anims.play("Death")
		$AnimationPlayer.play("fade_out")
		$SFX/LightHurt.stop()
		$SFX/LightDeath.play()
		dead = true
		checking_input = false
	if is_on_floor() and falling and not animating and not jumping and not climbing:
		landing = true
		$Anims.play("Land")
		$SFX/Footjumpland.play()
		falling = false
		jumping = false
	if is_on_floor() and jump_buffer and not climbing:
		$SFX/Footjump.play()
		velocity.y = JUMP_VELOCITY * gravity_multiplier
		checking_input = true
		animating = false
		jumping = true
		falling = true
		jump_buffer = false
		$Anims.play("Jump")
		landing = false
	if is_on_floor() and not climbing:
		$Shadow.modulate = Color(1,1,1,1)
	else:
		$Shadow.modulate = Color(1,1,1,0)

	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or not $CoyoteTime.is_stopped()) and checking_input:
		$SFX/Footjump.play()
		velocity.y = JUMP_VELOCITY * gravity_multiplier
		jumping = true
		falling = true
		jump_buffer = false
	elif Input.is_action_just_pressed("ui_accept"):
		jump_buffer = true
		$JumpBuffer.start()

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and checking_input:
		if $WalkTimer.is_stopped() and is_on_floor():
			$SFX/Footstep2.play()
			$WalkTimer.start()
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
		$WalkTimer.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	ledge_detect()
	
	if Input.is_action_just_pressed("Take Damage") and is_on_floor() and checking_input:
		animating = true
		$AnimationPlayer.play("invincible")
		$Anims.play("Self_Damage")
		$Mercury.visible = true
		$Mercury.frame = 0
		$Mercury.play("default")
		checking_input = false
		Global.light_up = true
		$SFX/MercFizzle.play()
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
	Global.damage()
	$IFrames.start()
	invincible = true
	if current_life != Global.current_life_total:
		current_life = Global.current_life_total

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
	if "Spike" in area.name and not invincible:
		$AnimationPlayer.play("fade_out")
		animating = true
		$Anims.play("Damaged")
		checking_input = false
		$SFX/LightHurt.play()
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
	elif $Anims.animation in ["Self_Damage", "Interact"]:
		animating = false
		checking_input = true
		$Anims.play("Idle")
		if is_on_floor():
			falling = false
	elif $Anims.animation == "Damaged":
		global_position = Global.respawn_pos
		$AnimationPlayer.stop()
		$Anims.modulate = Color(1,1,1,1)
		animating = false
		checking_input = true
		$Anims.play("Idle")
		if is_on_floor():
			falling = false
	elif $Anims.animation == "Death":
		get_tree().change_scene_to_file("res://UI/main_menu.tscn")

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


func _on_mercury_animation_finished():
	$Mercury.visible = false


func _on_walk_timer_timeout():
	if foot == 'right':
		$SFX/Footstep1.play()
		foot = "left"
	elif foot == "left":
		$SFX/Footstep2.play()
		foot = "right"


func _on_i_frames_timeout():
	invincible = false
	$AnimationPlayer.stop()
	$Anims.modulate = Color(1,1,1,1)

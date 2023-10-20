extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0
const DOUBLE_JUMP_VELOCITY = -250.0
const CLIMB_SPEED = 100.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_on_ladder = false
var jumps = 0

@onready var player_animations = $PlayerAnimations

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if is_on_floor():
		jumps = 0
	elif is_on_ladder:
		velocity.y = 0
	else:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and jumps < 2:
		velocity.y = JUMP_VELOCITY if jumps < 1 else DOUBLE_JUMP_VELOCITY
		jumps += 1

	if direction:
		velocity.x = direction * SPEED
		player_animations.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		player_animations.stop()
		
	if direction == 1:
		player_animations.flip_h = true
	elif direction == -1:
		player_animations.flip_h = false
		
	if Input.is_action_pressed("ui_up") and is_on_ladder == true:
		velocity.y -= CLIMB_SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y += CLIMB_SPEED

	move_and_slide()

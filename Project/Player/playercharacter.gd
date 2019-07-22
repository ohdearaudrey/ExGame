extends KinematicBody2D

const GRAVITY = 200.0
const WALK_SPEED = 200

var velocity = Vector2()

var isAttacking = false

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	# we only want movement inputs to change if we aren't in an attacking state
	if !isAttacking:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -WALK_SPEED
			$Sprite.flip_h = false
		elif Input.is_action_pressed("ui_right"):
			velocity.x =  WALK_SPEED
			$Sprite.flip_h = true
		else:
			velocity.x = 0
	
		# if the player velociy is > 0, play the walk animation
		if abs(velocity.x) > 0:
			$AnimationPlayer.play("walk")
		# otherwise, play the idle animation
		else:
			$AnimationPlayer.play("idle")
	
	# if the player presses attack, check if they aren't already attacking and
	# play the attack animation and set isAttacking to true
	if Input.is_action_just_pressed("attack"):
		if !isAttacking:
			$AnimationPlayer.play("attack")
			isAttacking = true

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.
	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))

func _on_AnimationPlayer_animation_finished(animation_name):
	# when the attack animation finishes, set isAttacking to false
	if animation_name == "attack":
		isAttacking = false

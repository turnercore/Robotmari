class_name Player
extends CharacterBody3D

@export_category("Movement")
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var ROTATION_SPEED = 1.0

# Current: Tank controls
# Can rotate OR move, but can't move while rotating


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Vector3()
	
	# Rotate the input direction based on the player's rotation
	# Handle rotation first
	
	var rotating: = false
	
	if Input.is_action_pressed("right"):
		rotation.y -= ROTATION_SPEED * delta
		rotating = true
	if Input.is_action_pressed("left"):
		rotation.y += ROTATION_SPEED * delta
		rotating = true


	# Get the input direction and handle the movement/deceleration.
	# Get forward/backwards direction
	if Input.is_action_pressed("forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("back"):
		input_dir.z += 1
		
	var forward_direction := (transform.basis * input_dir).normalized()
	
	# Apply the correct velocity based on the direction and speed.
	if forward_direction != Vector3.ZERO and not rotating:
		velocity.x = forward_direction.x * SPEED
		velocity.z = forward_direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0
	
	move_and_slide()

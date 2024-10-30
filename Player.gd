extends CharacterBody3D

@onready var boom_arm = $"Boom Arm"
@onready var camera_3d = $"Boom Arm/Camera3D"

const SPEED = 15.0 
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 0.02

const MAX_VERTICAL_ROTATION = 60
const MIN_VERTICAL_ROTATION = -90

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * ROTATION_SPEED)
		boom_arm.rotate_x(event.relative.y * ROTATION_SPEED)
		
		#clamp vertical rotation
		boom_arm.rotation_degrees.x = clampf(boom_arm.rotation_degrees.x, MIN_VERTICAL_ROTATION, MAX_VERTICAL_ROTATION)

func _physics_process(delta):
	_do_motion(delta)
	
func _do_motion(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Move Left", "Move Right", "Move Forward", "Move Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

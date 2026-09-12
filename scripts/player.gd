extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const acceleration = 660
var coyote = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D
@onready var coyote_timer: Timer = $"coyote timer"


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("moveL", "moveR")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
		coyote = true
	if not is_on_floor():
		coyote_timer.start()
		if Input.is_action_just_pressed("jump") and coyote == true:
			velocity.y = JUMP_VELOCITY
	
	#linear movement
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/10)

	move_and_slide()


func _on_coyote_timer_timeout() -> void:
	coyote = false

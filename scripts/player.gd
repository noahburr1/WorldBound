extends CharacterBody2D

var health = 100
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const acceleration = 660
var coyote = true
var interactiontime = true


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D
@onready var coyote_timer: Timer = $"coyote timer"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box: Area2D = $"hit box"
@onready var interaction_timer: Timer = $"hit box/interaction timer"

func _ready() -> void:
	health = Global.playerhealth

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
	
	#hit box interaction script
	if Input.is_action_just_pressed("interact") and interactiontime:
		hit_box.monitoring = true
		interactiontime = false
		interaction_timer.start()
		
		
	#animations process
	if is_on_floor() and direction:
		animated_sprite_2d.play("running")
	elif is_on_floor() and direction == 0:
		animated_sprite_2d.play("idle")
	
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	move_and_slide()


func _on_coyote_timer_timeout() -> void:
	coyote = false


func _on_hit_box_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_hit_box_body_entered(body: Node2D) -> void:
	pass


func _on_interaction_timer_timeout() -> void:
	pass # Replace with function body.

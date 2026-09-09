extends CharacterBody2D


const SPEED = 149.0
const JUMP_VELOCITY = -400.0
var player
var follow_distance = 80
var is_tamed = false
@onready var wallcast: RayCast2D = $CollisionShape2D/wallcast
@onready var floorcast: RayCast2D = $CollisionShape2D/floorcast
@onready var playercast: RayCast2D = $CollisionShape2D/playercast
@onready var area_2d: Area2D = $CollisionShape2D/Area2D
@export var pet_data: PetData



func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# raycasts for jump
	if wallcast.is_colliding() and floorcast.is_colliding():
		velocity.y = JUMP_VELOCITY
	elif not floorcast.is_colliding():
		velocity.x = 0
		
	if is_tamed:
		#follow player
		var direction = global_position.direction_to(player.global_position)
		if player == null:
			return
		var distance =global_position.distance_to(player.global_position)
		if distance > 900:
			global_position = player.global_position
			
		if distance > follow_distance:
			
			
			velocity.x = SPEED * direction.x
		
		else:
			velocity.x = 0
		if direction.x > 0:
			wallcast.scale.x = 1
			floorcast.rotation = 0
		elif direction.x < 0:
			wallcast.scale.x = -1
			floorcast.rotation = -320
	
	#bounce off of head
	

	move_and_slide()



func follow_player(delta: float):
	var direction = global_position.direction_to(player.global_position)
	if player == null:
		return
	var distance =global_position.distance_to(player.global_position)
	if distance > 900:
		global_position = player.global_position
		
	if distance > follow_distance:
		
		velocity.x = SPEED * direction
	
	else:
		velocity.x = 0
	if direction.x >0:
		wallcast.scale.x = 1
		floorcast.rotation = 0
	elif direction.x < 0:
		wallcast.scale.x = -1
		floorcast.rotation = -320


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.bounce()
		velocity.y = 0

func hit():
	is_tamed = true
	Inventory.add_pet(pet_data)
	self.queue_free()

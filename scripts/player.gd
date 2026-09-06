extends CharacterBody2D
var dbljumps = Global.maxDbljumps
var sliding = false
var acceleration = 800
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var totalknockback = Vector2.ZERO
var swinging = false
var canmove = true
var canswing = Global.canswing
var hascoyotetime = true

#test note tablet test 5

@onready var character_sprite: AnimatedSprite2D = $characterSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $playerhitbox
@onready var interact_box: Area2D = $"interact box"
@onready var main_health_bar: ProgressBar = $"Camera2D/CanvasLayer/healthbar/main health bar"
@onready var secondary_health_bar: ProgressBar = $"Camera2D/CanvasLayer/healthbar/secondary health bar"
@onready var damage_timer: Timer = $"Camera2D/CanvasLayer/Control/secondary health bar/damage timer"
@onready var inventory_ui: Control = $"Camera2D/CanvasLayer/inventory UI"

func _ready() -> void:
	#set health bar values on player reset
	main_health_bar.value = Global.health
	main_health_bar.max_value = Global.maxhealth
	secondary_health_bar.max_value = Global.maxhealth
	secondary_health_bar.value = Global.health
	#sespawn point system to set player position on scene instantiation
	var scene_name = get_tree().current_scene.name
	if Global.respawn_position.has(scene_name):
		global_position = Global.respawn_position[scene_name]
	

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("moveL", "moveR")
	
	#handle basic running movement
	if totalknockback != Vector2.ZERO:
		velocity = totalknockback
		
		totalknockback = Vector2.ZERO
	elif Input.is_action_pressed("slide"):
		if Input.is_action_just_pressed("slide") and velocity.x == 200 *direction:
			velocity.x += 160 * direction
		velocity.x = move_toward(velocity.x, direction * 60, 200 * delta)
	elif canmove:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, direction * SPEED, acceleration * delta) 
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, direction * SPEED, 700 * delta)

	
	
	if canswing != Global.canswing:
		canswing = Global.canswing
	
	#enable interaction hitbox
	if Input.is_action_just_pressed("interact"):
		interact_box.monitoring = true
		await get_tree().create_timer(.02).timeout
		interact_box.monitoring = false
	
	#death
	if Global.health <= 0:
		get_tree().reload_current_scene()
		Global.health = Global.maxhealth
	
	#gravity and coyote time
	if not is_on_floor():
		velocity += get_gravity() * delta
		if hascoyotetime == true:
			coyotetimer()
	if is_on_floor():
		dbljumps = Global.maxDbljumps
		hascoyotetime = true

	# Handle jump and coyote time aplication
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		if not is_on_floor():
			if hascoyotetime == true:
				velocity.y = JUMP_VELOCITY
				hascoyotetime = false
			

	
	#wall jump
	if is_on_wall_only():
		if Input.is_action_just_pressed("jump") and dbljumps > 0:
			velocity.y = JUMP_VELOCITY
			velocity.x += -150 * direction
			dbljumps -= 1

#dash ability
	if Input.is_action_just_pressed("dash") and dbljumps > 0:
		if not is_on_floor():
			dbljumps -=1
		velocity.x += direction * 200
		velocity.y -= 50
		
	
	
	
	
	
	#animation scripts
	if direction < 0:
		character_sprite.flip_h = true
		hitbox.position.x = -40
	if direction > 0:
		character_sprite.flip_h = false
		hitbox.position.x = 0
	if Input.is_action_just_pressed("dash") and swinging == false:
		character_sprite.play("roll")
	if not is_on_floor():
		if Input.is_action_just_pressed("mouseL"):
			animation_player.play("attack")
		elif dbljumps != Global.maxDbljumps and swinging == false:
			character_sprite.play("roll")
			animation_player.play("rollingHB")
		else:
			animation_player.play("standardHB")
			character_sprite.play("jump")
	elif is_on_floor() :
		
		if Input.is_action_just_pressed("mouseL") and canswing:
			animation_player.play("attack")
			character_sprite.play("attack")
			swinging = true
			velocity.x = 0
			await get_tree().create_timer(.5).timeout
			animation_player.play("standardHB")
			swinging = false
			
		
		elif direction != 0 and swinging == false:
			character_sprite.play("walking")
			animation_player.play("standardHB")
		elif swinging == false:
			character_sprite.play("idle")
			animation_player.play("standardHB")

	move_and_slide()

func player_take_damage(damage: int, enemyposition: Vector2, knockbackforce: float):
	Global.health -= damage
	var knockdirection = (global_position - enemyposition).normalized()
	
	totalknockback = knockdirection * knockbackforce
	main_health_bar.value = Global.health
	
	damage_timer.start()


#interact button
func _on_interact_box_area_entered(area: Area2D) -> void:
	
	var interactable = area.get_parent()
	if interactable.is_in_group("interactable"):
		interactable.interact()

func coyotetimer():
	await get_tree().create_timer(.1).timeout
	hascoyotetime = false
	
func update_second_health_bar():
	
	secondary_health_bar.value = Global.health
	
	
	#notes: shop exit X, spawn positions X, 


func _on_damage_timer_timeout() -> void:
	update_second_health_bar()
	
#bounce is from greenslime pet
func bounce():
	velocity.y = -590

func use_item(effect: String):
	match effect:
		"small heal":
			heal(25)

#effect functions
func heal(amount: int):
	if Global.health < Global.maxhealth:
		Global.health += amount
		main_health_bar.value = Global.health
		
	if Global.health >= Global.maxhealth:
		var difference = Global.maxhealth - Global.health
		Global.health -= difference
		main_health_bar.value = Global.health

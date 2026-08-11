extends CharacterBody2D
var dbljumps = Global.maxDbljumps
var sliding = false
var acceleration = 900
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var rejump = false
var totalknockback = Vector2.ZERO
var swinging = false
var canmove = true
var canswing = Global.canswing
var hascoyotetime = true

#test note for initial repository creation

@onready var character_sprite: AnimatedSprite2D = $characterSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $playerhitbox
@onready var interact_box: Area2D = $"interact box"
@onready var main_health_bar: ProgressBar = $"Camera2D/CanvasLayer/Control/main health bar"
@onready var secondary_health_bar: ProgressBar = $"Camera2D/CanvasLayer/Control/secondary health bar"
@onready var damage_timer: Timer = $"Camera2D/CanvasLayer/Control/secondary health bar/damage timer"

func _ready() -> void:
	
	main_health_bar.value = Global.health
	main_health_bar.max_value = Global.maxhealth
	secondary_health_bar.max_value = Global.maxhealth
	secondary_health_bar.value = Global.health
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
		velocity.x = move_toward(velocity.x, direction * 60, 120 * delta)
	elif canmove:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, direction * SPEED, acceleration * delta) 
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, direction * SPEED, 700 * delta)

	
	
	if canswing != Global.canswing:
		canswing = Global.canswing
	
	if Input.is_action_just_pressed("interact"):
		interact_box.monitoring = true
		await get_tree().create_timer(.02).timeout
		interact_box.monitoring = false
	
	
	if Global.health <= 0:
		get_tree().reload_current_scene()
		Global.health = Global.maxhealth
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if hascoyotetime == true:
			coyotetimer()
	if is_on_floor():
		dbljumps = Global.maxDbljumps
		hascoyotetime = true

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		if not is_on_floor() and dbljumps > 0:
			if hascoyotetime == true:
				velocity.y = JUMP_VELOCITY
				hascoyotetime = false
			else:
				dbljumps -= 1
				velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	
	if is_on_wall_only():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			velocity.x += -150 * direction
			dbljumps = Global.maxDbljumps
	if Input.is_action_just_pressed("mouseR") and rejump == true and Global.dashJump == true:
		var dashDirection = (get_global_mouse_position()-global_position).normalized()
		velocity += dashDirection * 500
		
		
	if Input.is_action_just_pressed("dash") and dbljumps > 0:
		if not is_on_floor() and not is_on_wall():
			dbljumps -=1
		velocity.x += direction*500
		velocity.y -=200
		rejump = true
		await get_tree().create_timer(.5).timeout
		rejump = false
	
	if Input.is_action_pressed("timeslow"):
		Engine.time_scale = .75
	else:
		Engine.time_scale = 1
	
	
	
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

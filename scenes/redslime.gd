extends CharacterBody2D

@export var gem: PackedScene
@onready var animated_sprite: AnimatedSprite2D = $redslimeArea/AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $redslimeArea/RayCast2D

const speed = 60.0
var direction = 1
var health = 50
var canmove = true


func ready():
	animated_sprite.flip_h = true
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if canmove:
		velocity.x = direction * speed
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider.is_in_group("player"):
			pass
		else:
			flip()
	
	move_and_slide()


func flip():
	direction *= -1
	
	scale.x *= -1

func take_hit(damage: int, playerposition: Vector2, knockback: int):
	animated_sprite.play("damage")
	
	var knockdirection = (global_position - playerposition).normalized()
	health -= damage
	
	if health <= 0:
		die()
	else:
		canmove = false
		velocity = knockdirection * knockback
		velocity.y += -100
		await get_tree().create_timer(.15).timeout
		canmove = true

func die():
	var new_gem = gem.instantiate()
	get_tree().current_scene.add_child(new_gem)
	new_gem.global_position = global_position
	Global.coins += 1
	queue_free()

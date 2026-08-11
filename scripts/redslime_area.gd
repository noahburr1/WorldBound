extends Area2D

var damage = 25
var knockback = 350


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.player_take_damage(damage, global_position, knockback)

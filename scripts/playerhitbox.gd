extends Area2D

var damage = Global.damage
var knockbackforce = Global.knockforce


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var position = get_parent().global_position
		body.take_hit(damage, position, knockbackforce)
		

		

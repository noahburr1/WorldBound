extends Node2D
@onready var spawn_point: Node2D = $"../spawn point"


func interact():
	var scene_name = get_tree().current_scene.name
	Global.respawn_position[scene_name] = spawn_point.global_position
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
	print("interacting")

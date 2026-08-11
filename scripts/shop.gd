extends Node2D

@onready var camera_2d: Camera2D = $Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.canswing = false
	camera_2d.make_current()
	
	
	
	


func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/main_screen.tscn")
		Global.canswing = true
		print("body entered")
	

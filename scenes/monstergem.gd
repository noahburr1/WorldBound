extends RigidBody2D
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity.y = -300
	label.visible = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	label.visible = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	label.visible = false

func interact():
	Global.totalgems += 1
	queue_free()
	print(Global.totalgems)

extends Area2D
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false



func _on_area_entered(area: Area2D) -> void:
	label.visible = true


func _on_area_exited(area: Area2D) -> void:
	label.visible = false

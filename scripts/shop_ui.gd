extends CanvasLayer
@onready var UI: Control = $Control

func _ready() -> void:
	UI.visible = false

func open_shop():
	UI.visible = true

func close_shop():
	UI.visible = false

extends Area2D

@export var item: ItemData
@onready var sprite_2d: Sprite2D = $Sprite2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Inventory.add_item(item)
		self.queue_free()

func _ready() -> void:
	sprite_2d.texture = item.displayed_texture

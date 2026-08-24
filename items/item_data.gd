class_name ItemData
extends Resource

@export var id: String
@export var item_name: String
@export var icon: Texture2D
@export var displayed_texture: Texture2D
@export var description: String
@export var max_stack = 32
@export var effect: String
@export var quantity: int
@export_enum("Interactable", "Placeable") var world_behavior: String = "Interactable"
@export var world_scene: PackedScene

extends Control

@export var slot_index1: int = 0
@export var slot_index2: int = 1
@export var slot_index3: int = 2
@export var slot_index4: int = 3
@export var slot_index5: int = 4
@export var slot_index6: int = 5

@onready var hb_slot_1: Button = $"HBoxContainer/HB slot 1"
@onready var hb_slot_2: Button = $"HBoxContainer/HB slot 2"
@onready var hb_slot_3: Button = $"HBoxContainer/HB slot 3"
@onready var hb_slot_4: Button = $"HBoxContainer/HB slot 4"
@onready var hb_slot_5: Button = $"HBoxContainer/HB slot 5"
@onready var hb_slot_6: Button = $"HBoxContainer/HB slot 6"

@onready var pet_slot_1: Button = $"HBoxContainer2/pet slot 1"
@onready var pet_slot_2: Button = $"HBoxContainer2/pet slot 2"
@onready var pet_slot_3: Button = $"HBoxContainer2/pet slot 3"
@onready var pet_slot_4: Button = $"HBoxContainer2/pet slot 4"

func update_item_hotbar():
	var slots = [
		hb_slot_1,
		hb_slot_2,
		hb_slot_3,
		hb_slot_4,
		hb_slot_5,
		hb_slot_6
	]

	for i in range(slots.size()):
		slots[i].icon = null
		slots[i].get_node("Label").text = ""

		if Inventory.hotbar_items[i] != null:
			slots[i].icon = Inventory.hotbar_items[i]["item"].icon
			slots[i].get_node("Label").text = str(Inventory.hotbar_items[i]["quantity"])
func _ready() -> void:
	Inventory.inventory_changed.connect(update_item_hotbar)
	update_item_hotbar()
	

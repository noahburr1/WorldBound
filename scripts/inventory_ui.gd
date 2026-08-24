extends Control

@onready var grid_container: GridContainer = $Panel/VBoxContainer/GridContainer
@onready var items_button: Button = $"Panel/VBoxContainer/tabs/Items Button"
@onready var materials_button: Button = $"Panel/VBoxContainer/tabs/Materials Button"
@onready var pets_button: Button = $"Panel/VBoxContainer/tabs/Pets Button"
@onready var petslot_1: Button = $"Panel/pet hotbar/petslot1"
@onready var petslot_2: Button = $"Panel/pet hotbar/petslot2"
@onready var petslot_3: Button = $"Panel/pet hotbar/petslot3"
@onready var petslot_4: Button = $"Panel/pet hotbar/petslot4"

const slot_scene = preload("res://scenes/inventory_slot.tscn")
var current_tab := "items"
const material_slot_scene = preload("res://scenes/material_slot.tscn")


func update_inventory():
	
	for child in grid_container.get_children():
		child.queue_free()
	if current_tab == "items":
		show_items()
	elif current_tab == "pets":
		show_pets()
	elif current_tab == "materials":
		show_materials()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _ready() -> void:
	Inventory.inventory_changed.connect(update_inventory)
	items_button.button_pressed = true
	update_inventory()


func _on_items_button_pressed() -> void:
	materials_button.button_pressed = false
	pets_button.button_pressed = false
	items_button.button_pressed = true
	current_tab = "items"
	update_inventory()


func _on_materials_button_pressed() -> void:
	items_button.button_pressed = false
	pets_button.button_pressed = false
	materials_button.button_pressed = true
	current_tab = "materials"
	update_inventory()


func _on_pets_button_pressed() -> void:
	materials_button.button_pressed = false
	items_button.button_pressed = false
	pets_button.button_pressed = true
	current_tab = "pets"
	update_inventory()

func show_items():
	for i in range(Inventory.items.size()):
		var item_slot = Inventory.items[i]

		var slot = slot_scene.instantiate()
		grid_container.add_child(slot)

		slot.slot_index = i

		if item_slot != null:
			slot.set_item(item_slot["item"], item_slot["quantity"])
		
		if item_slot != null:
			slot.set_item(item_slot["item"], item_slot["quantity"])

func show_materials():
	for material_id in Inventory.materials:
		var amount = Inventory.materials[material_id]
		var slot = material_slot_scene.instantiate()
		grid_container.add_child(slot)
		slot.text = material_id + " x" + str(amount)

func show_pets():
	
	
	
	for pet in Inventory.pets:
		var slot = slot_scene.instantiate()
		grid_container.add_child(slot)
		if pet != null:
			slot.set_pet(pet)
		

func update_pet_hotbar():
	petslot_1.icon = null
	petslot_2.icon = null
	petslot_3.icon = null
	petslot_4.icon = null
	
	if Inventory.equipped_pets[0] != null:
		petslot_1.icon = Inventory.equipped_pets[0].icon
	if Inventory.equipped_pets[1] != null:
		petslot_2.icon = Inventory.equipped_pets[1].icon
	if Inventory.equipped_pets[2] != null:
		petslot_3.icon = Inventory.equipped_pets[2].icon
	if Inventory.equipped_pets[3] != null:
		petslot_4.icon = Inventory.equipped_pets[3].icon

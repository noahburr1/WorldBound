extends Control

@export var slot_index1: int = 0
@export var slot_index2: int = 1
@export var slot_index3: int = 2
@export var slot_index4: int = 3
@export var slot_index5: int = 4
@export var slot_index6: int = 5
var selected_slot = 0
signal update_pets

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
	update_pet_hotbar()
func _ready() -> void:
	Inventory.inventory_changed.connect(update_item_hotbar)
	update_item_hotbar()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		selected_slot = 0
		update_hotbar_ui()
	if Input.is_action_just_pressed("2"):
		selected_slot = 1
		update_hotbar_ui()
	if Input.is_action_just_pressed("3"):
		selected_slot = 2
		update_hotbar_ui()
	if Input.is_action_just_pressed("4"):
		selected_slot = 3
		update_hotbar_ui()
	if Input.is_action_just_pressed("5"):
		selected_slot = 4
		update_hotbar_ui()
	if Input.is_action_just_pressed("6"):
		selected_slot = 5
		update_hotbar_ui()
	if Input.is_action_just_pressed("7"):
		selected_slot = 6
		update_hotbar_ui()
	if Input.is_action_just_pressed("8"):
		selected_slot = 7
		update_hotbar_ui()
	if Input.is_action_just_pressed("9"):
		selected_slot = 8
		update_hotbar_ui()
	if Input.is_action_just_pressed("0"):
		selected_slot = 9
		update_hotbar_ui()
	if Input.is_action_just_pressed("interact"):
		if selected_slot <= 5:
			use_selected_item()
			update_hotbar_ui()
		if selected_slot>=6:
			use_selected_pet()
			update_pets.emit()
	
	
func use_selected_item():
	var stack = Inventory.hotbar_items[selected_slot]
	if stack == null:
		print("null stack")
		return
	var item: ItemData = stack["item"]
	if item.world_behavior == "Interactable":
		var player = get_tree().get_first_node_in_group("player")
		if item.effect != null:
			player.use_item(item.effect)
			print("using item")

func use_selected_pet():
	pass

func update_hotbar_ui():
	var slots = [
		hb_slot_1,
		hb_slot_2,
		hb_slot_3,
		hb_slot_4,
		hb_slot_5,
		hb_slot_6,
		pet_slot_1,
		pet_slot_2,
		pet_slot_3,
		pet_slot_4
	]
	for i in range(slots.size()):
		if selected_slot == i:
			slots[i].button_pressed = true
		elif selected_slot != i:
			slots[i].button_pressed = false

func update_pet_hotbar():
	var slots = [
	pet_slot_1,
	pet_slot_2,
	pet_slot_3,
	pet_slot_4 
	]
	
	for i in range(slots.size()):
		slots[i].icon = null
		

		if Inventory.equipped_pets[i] != null:
			slots[i].icon = Inventory.equipped_pets[i].icon
			
	
	

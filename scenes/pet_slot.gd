extends Button

@export var slot_index: int = 0
var pet_data: PetData = null


func set_pet(data: PetData):
	pet_data = data
	if pet_data != null:
		icon = pet_data.icon
		
		
	else:
		icon = null
		
		
func clear_pet():
	pet_data = null
	icon = null
	
	
func update_slot():
	if Inventory.equipped_pets[slot_index] == null:
		return
	else:
		var player = get_tree().get_first_node_in_group("player")
		var data = Inventory.equipped_pets[slot_index]
		var pet_tcsn = data.pet_scene
		get_tree().current_scene.add_child(pet_tcsn)
		pet_tcsn.is_tamed = true
		pet_tcsn.global_position = player.global_position + Vector2(15, 5)
		set_pet(data)
	

func _ready() -> void:
	Inventory.inventory_changed.connect(update_slot)
	update_slot()

func _can_drop_data(_at_position, data):
	return data is Dictionary and (
		data.get("type") == "pet"
		or data.get("type") == "hotbar_pet"
	)
	
func _drop_data(_at_position, data):
	if data["type"] == "pet":
		var from_inventory_slot: int = data["slot_index"]
		var new_pet: PetData = data["pet"]
		var old_pet = Inventory.equipped_pets[slot_index]
	
		Inventory.equipped_pets[slot_index] = new_pet
	
		if old_pet == null:
			Inventory.pets.remove_at(from_inventory_slot)
		else:
			Inventory.pets[from_inventory_slot] = old_pet
	
		Inventory.inventory_changed.emit()
	
	elif data["type"] == "hotbar_pet":
		var from_slot: int = data["pet_hotbar_slot"]

		if from_slot == slot_index:
			return

		var temp = Inventory.equipped_pets[slot_index]

		Inventory.equipped_pets[slot_index] = Inventory.equipped_pets[from_slot]
		Inventory.equipped_pets[from_slot] = temp

		Inventory.inventory_changed.emit()
		

func _get_drag_data(_at_position):
	var pet = Inventory.equipped_pets[slot_index]

	if pet == null:
		return null

	var preview = TextureRect.new()
	preview.texture = pet.icon
	preview.size = Vector2(64, 64)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE

	set_drag_preview(preview)

	return {
		"type": "hotbar_pet",
		"pet": pet,
		"pet_hotbar_slot": slot_index
	}


func _process(delta: float) -> void:
	pass

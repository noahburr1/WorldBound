extends Node

var max_slots = 20
var items: Array = []
var pets: Array[PetData] = []
var hotbar_items = [null, null, null, null, null, null]
var equipped_pets = [null, null, null, null]
var materials: Dictionary = {}

signal inventory_changed

func _ready() -> void:
	
	for i in max_slots:
		items.append(null)
	
	
	
	
func add_item(item: ItemData):
	for i in range(max_slots):
		if items[i] != null and items[i]["item"] == item:
			if items[i]["quantity"] < item.max_stack:
				items[i]["quantity"] += 1
				inventory_changed.emit()
				return

		if items[i] == null:
			items[i] = {"item": item, "quantity": 1}
			inventory_changed.emit()
			return
	

func add_pet(pet: PetData):
	print("ADDING PET: ", pet)

	pets.append(pet)

	print("PETS ARRAY: ", pets)

	inventory_changed.emit()

func add_material(material_id: String, amount: int):
	if materials.has(material_id):
		materials[material_id] += amount
	else:
		materials[material_id] = amount



func equip_pet(pet: PetData):
	for i in range(equipped_pets.size()):
		if equipped_pets[i] == null:
			equipped_pets[i] = pet
			inventory_changed.emit()
			return
	print("All pet slots are full!")

func unequip_pet(slot_index: int):
	if slot_index >= 0 and slot_index < equipped_pets.size():
		equipped_pets[slot_index] = null
		inventory_changed.emit()

#hotbar scripts:
func move_item_to_hotbar(item_data: Dictionary, slot_index: int):
	if slot_index < 0 or slot_index >= hotbar_items.size():
		return

	hotbar_items[slot_index] = item_data
	inventory_changed.emit()


func _process(delta: float) -> void:
	pass

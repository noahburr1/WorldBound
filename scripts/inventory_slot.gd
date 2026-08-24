extends Button
@onready var quantity_label: Label = $"quantity label"
@onready var texture_rect: TextureRect = $TextureRect

var slot_index: int = -1
var item: ItemData
var quantity: int = 0

func set_item(item_data: ItemData, amount: int):
	item = item_data
	quantity = amount
	
	if item.icon:
		icon = item.icon
	quantity_label.text = str(quantity)
	texture_rect.texture = item.icon

func set_pet(pet: PetData):
	item = null
	icon = pet.icon
	quantity_label.text = ""

func _get_drag_data(_at_position):
	if item == null:
		return null
	
	var preview = TextureRect.new()
	preview.texture = item.icon
	preview.expand_mode = texture_rect.EXPAND_IGNORE_SIZE
	preview.size = Vector2 (64, 64)
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview.position = -preview.size / 2
	
	set_drag_preview(preview)
	return {
	"type": "item",
	"item": item,
	"slot_index": slot_index
}

func _can_drop_data(_at_position, data):
	return data is Dictionary and (
		data.get("type") == "item"
		or data.get("type") == "hotbar_item"
	)
	
func _drop_data(_at_position, data):
	if data["type"] == "item":
		var from_slot: int = data["slot_index"]

		if from_slot == slot_index:
			return

		var temp = Inventory.items[slot_index]
		Inventory.items[slot_index] = Inventory.items[from_slot]
		Inventory.items[from_slot] = temp

		Inventory.inventory_changed.emit()

	elif data["type"] == "hotbar_item":
		var from_slot: int = data["hotbar_slot"]
		var stack: Dictionary = data["stack"]

		Inventory.items[slot_index] = stack
		Inventory.hotbar_items[from_slot] = null

		Inventory.inventory_changed.emit()

extends Button

@export var slot_index: int = 0
@onready var label: Label = $Label


func _ready() -> void:
	Inventory.inventory_changed.connect(update_item_hotbar)


func _can_drop_data(_at_position, data):
	return data is Dictionary and (
		data.get("type") == "item"
		or data.get("type") == "hotbar_item"
	)


func _drop_data(_at_position, data):
	if data["type"] == "item":
		var from_inventory_index: int = data["slot_index"]

		Inventory.hotbar_items[slot_index] = Inventory.items[from_inventory_index]
		Inventory.items[from_inventory_index] = null

		Inventory.inventory_changed.emit()

	elif data["type"] == "hotbar_item":
		var from_slot: int = data["hotbar_slot"]

		if from_slot == slot_index:
			return

		var temp = Inventory.hotbar_items[slot_index]

		Inventory.hotbar_items[slot_index] = Inventory.hotbar_items[from_slot]
		Inventory.hotbar_items[from_slot] = temp

		Inventory.inventory_changed.emit()
func update_item_hotbar():
	pass

func _get_drag_data(_at_position):
	var item = Inventory.hotbar_items[slot_index]

	if item == null:
		return null

	var preview = Control.new()
	preview.size = Vector2(64, 64)
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var texture = TextureRect.new()
	texture.texture = item["item"].icon
	texture.size = Vector2(32, 32)
	texture.position = Vector2(16, 16)
	texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture.mouse_filter = Control.MOUSE_FILTER_IGNORE

	preview.add_child(texture)

	set_drag_preview(preview)

	return {
		"type": "hotbar_item",
		"stack": item,
		"hotbar_slot": slot_index
	}

	

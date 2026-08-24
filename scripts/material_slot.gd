extends Button

@onready var label: Label = $Label

var material_id: String
var quantity: int


func setup_material(id: String, amount: int, icon: Texture2D):
	material_id = id
	quantity = amount
	self.icon = icon
	label.text = str(quantity)

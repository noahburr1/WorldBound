extends Control

@onready var abilities_tab: Button = $"Panel/HBoxContainer/abilities tab"
@onready var player_tab: Button = $"Panel/HBoxContainer/player tab"
@onready var abilities_upgrades: GridContainer = $"Panel/upgrade menu/abilities upgrades"
@onready var player_upgrades: GridContainer = $"Panel/upgrade menu/player upgrades"

func _ready() -> void:
	player_tab.button_pressed = false
	player_upgrades.visible = false
	abilities_upgrades.visible = true

func _on_abilities_tab_button_down() -> void:
	player_tab.button_pressed = false
	player_upgrades.visible = false
	abilities_upgrades.visible = true


func _on_player_tab_button_down() -> void:
	abilities_tab.button_pressed = false
	abilities_upgrades.visible = false
	player_upgrades.visible = true

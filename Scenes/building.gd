class_name Building extends Node2D

@onready var interaction_zone : InteractionZone = $"Interaction Zone"
@onready var resource_fill_bar : ResourceFillBar = $ResourceFillBar
@onready var text_label_popup_node : TextLabelPopup = $TextLabelPopupNode

@export var action_cost : int = 5
@export var cost_increase: int = 2

var current_resources : int = 0

func on_resource_filled() -> void:
	action_cost += cost_increase
	resource_fill_bar.update_max()
	pass

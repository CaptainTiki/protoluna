class_name Building extends Node2D

@onready var interaction_zone : InteractionZone = $"Interaction Zone"
@onready var resource_fill_bar : ResourceFillBar = $ResourceFillBar
@onready var text_label_popup_node : TextLabelPopup = $TextLabelPopupNode

@export var display_text : String = "[center]Default Text![/center]"
@export var label_offset : Vector2 = Vector2(-120,-240)
@export var bar_label : String #this will display the cost of upgrading
@export var bar_size : Vector2 = Vector2(100,10)
@export var bar_offset : Vector2 = Vector2(-50,-220)

@export var action_cost : int = 5

var cost_increase: int = 2 #default - needs to be changed in init function
var current_resources : int = 0

func on_resource_filled() -> void:
	action_cost += cost_increase
	resource_fill_bar.update_max()
	pass

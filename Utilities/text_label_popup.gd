class_name TextLabelPopup extends Node2D

@onready var label : RichTextLabel = $RichTextLabel
@onready var interaction_zone : InteractionZone = $"../Interaction Zone"

var parentNode : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	parentNode = get_parent()
	label.text = parentNode.display_text
	label.visible = false
	label.position = parentNode.label_offset
	interaction_zone.player_entered.connect(_display_label)
	interaction_zone.player_exited.connect(_hide_label)
	pass 

func _process(_delta):
	pass

func _display_label() -> void:
	label.visible = true
	pass

func _hide_label() -> void:
	label.visible = false
	pass

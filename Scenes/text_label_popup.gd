class_name TextLabelPopup extends Node2D

@onready var label = $RichTextLabel
@onready var interaction_zone : InteractionZone = $"../Interaction Zone"

@export var display_text : String = "[center]Default Text![/center]"
@export var label_offset : Vector2 = Vector2(-120,-240)

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = display_text
	label.visible = false
	label.position = label_offset
	interaction_zone.player_entered.connect(_display_label)
	interaction_zone.player_exited.connect(_hide_label)
	pass 

func _process(delta):
	pass

func _display_label() -> void:
	label.visible = true
	pass

func _hide_label() -> void:
	label.visible = false
	pass

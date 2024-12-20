class_name ResourceFillBar extends Node2D

@onready var interaction_zone : InteractionZone = $"../Interaction Zone"
@onready var parent_blding_node : Building = $".."

@onready var label: RichTextLabel = $RichTextLabel
@onready var background_bar = $BackgroundBar
@onready var progress_bar = $ProgressBar

var filling : bool = false
var progress : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_zone.player_entered.connect(_display_bar)
	interaction_zone.player_exited.connect(_hide_bar)
	interaction_zone.interaction_triggered.connect(_start_fill_bar)
	interaction_zone.interaction_released.connect(_stop_fill_bar)
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if filling:
		progress += GameManager.interaction_speed * delta
		if progress >= 1:
			progress = 0
			progress_bar.value += 1
		if progress_bar.value >= progress_bar.max_value:
			parent_blding_node.on_resource_filled() #tell our parent we're full
			progress_bar.value = 0 #reset progress down to empty
		pass
	pass

func _display_bar() -> void:
	visible = true
	update_current()
	update_max()
	pass

func _hide_bar() -> void:
	visible = false
	pass

func update_current() -> void:
	progress_bar.value = parent_blding_node.current_resources
	label.text = parent_blding_node.bar_label

func update_max() -> void:
	progress_bar.max_value = parent_blding_node.action_cost
	pass

func _start_fill_bar() -> void:
	filling = true
	pass

func _stop_fill_bar() -> void:
	filling = false
	pass

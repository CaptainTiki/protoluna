class_name InteractionZone extends Area2D

@onready var parent_node = $".."
@onready var text_label_popup_node = $"../TextLabelPopupNode"
@onready var resource_fill_bar = $"../ResourceFillBar"

signal interaction_triggered
signal interaction_released
signal player_entered
signal player_exited

var player_in_zone : bool = false

func _ready() -> void:
	#connect signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	pass 

func _on_body_entered(body) -> void:
	if body.name == "Player_Drone":
		player_in_zone = true
		player_entered.emit()
	pass

func _on_body_exited(body) -> void:
	if body.name == "Player_Drone":
		player_in_zone = false
		player_exited.emit()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("interact"):
		interaction_triggered.emit()
	if player_in_zone and Input.is_action_just_released("interact"):
		interaction_released.emit()
	pass

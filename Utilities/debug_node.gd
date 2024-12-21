class_name Debug_Node extends Node

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var label: Label = $CanvasLayer/Panel/Label

@onready var time_label: Label = $CanvasLayer/Panel/VBoxContainer/Time
@onready var time_label_2: Label = $CanvasLayer/Panel/VBoxContainer/Time2

# Debug info (you can add more fields as needed)
var debug_info := {}

func _ready() -> void:
	if canvas_layer:
		canvas_layer.visible = false  # Start with the debug canvas hidden

func _process(_delta):
	# Toggle debug canvas visibility
	if Input.is_action_just_pressed("debug_show"):
		canvas_layer.visible = not canvas_layer.visible

	# Update debug information
	if canvas_layer.visible:
		update_debug_canvas()

func add_debug_info(key: String, value: String) -> void:
	debug_info[key] = value

func remove_debug_info(key: String) -> void:
	debug_info.erase(key)

func update_debug_canvas():
	if canvas_layer:
		if canvas_layer.visible:
			var debug_text = ""
			for key in debug_info.keys():
				debug_text += key + ": " + str(debug_info[key]) + "\n"
			$CanvasLayer/Panel/Label.text = debug_text

func update_time(is_daytime: bool, time: String) -> void:
	if time_label_2 && time_label:
		if is_daytime:
			time_label.text = "Daytime"
		else:
			time_label.text = "Nighttime"
		time_label_2.text = time 
	pass

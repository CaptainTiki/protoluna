extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
const HIGHLIGHT_SHADER_MATERIAL = preload("res://Assets/highlight_shader_material.tres")

var is_hovering  = false
var current_time: float = 0.0

func _ready() -> void:
	#set higlight to 0 on load
	HIGHLIGHT_SHADER_MATERIAL.set("shader_parameter/time", 0.0) #reset timer
	HIGHLIGHT_SHADER_MATERIAL.set("shader_parameter/glow_strength", 0.0)
	is_hovering  = false
	pass

func _process(delta) -> void:
	if is_hovering:
		#increment time for shader
		current_time += delta
		HIGHLIGHT_SHADER_MATERIAL.set("shader_parameter/time", current_time)

func _on_mouse_entered() -> void:
	is_hovering  = true
	HIGHLIGHT_SHADER_MATERIAL.set("shader_parameter/time", 0.0) #start timer
	HIGHLIGHT_SHADER_MATERIAL.set("shader_parameter/glow_strength", 0.2) #remove glow
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	is_hovering  = false
	HIGHLIGHT_SHADER_MATERIAL.set("shader_parameter/glow_strength", 0.0) #remove glow
	HIGHLIGHT_SHADER_MATERIAL.set("shader_parameter/time", 0.0) #reset timer
	pass # Replace with function body.

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#popup_menu
		pass # Replace with function body.

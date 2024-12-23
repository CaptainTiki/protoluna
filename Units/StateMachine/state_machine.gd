class_name StateMachine extends Node

@export var current_state : StateNode

# Called when the node enters the scene tree for the first time.
func _ready():
	change_state(current_state)
	pass # Replace with function body.

func change_state(new_state: StateNode):
	if current_state.state_exit_signal.is_connected(_on_state_exited):
		current_state.state_exit_signal.disconnect(_on_state_exited)
	new_state._enter_state()
	current_state = new_state
	current_state.state_exit_signal.connect(_on_state_exited)
	pass

func _on_state_exited() -> void:
	change_state(current_state.exit_state)
	pass

class_name StateMachine extends Node

@export var state : StateNode

# Called when the node enters the scene tree for the first time.
func _ready():
	change_state(state)
	pass # Replace with function body.

func change_state(new_state: StateNode):
	new_state._enter_state()
	state = new_state
	state.state_exited.connect(_on_state_exited)
	pass

func _on_state_exited() -> void:
	change_state(state.exit_state)
	pass

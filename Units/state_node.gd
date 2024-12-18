class_name StateNode extends Node

signal state_exited

func _enter_state() -> void:
	pass

func _exit_state() -> void:
	pass

func _get_rand_direction() -> int:
	var number : float = randf()
	if number  < 0.5: 
		return -1 
	else:
		return 1

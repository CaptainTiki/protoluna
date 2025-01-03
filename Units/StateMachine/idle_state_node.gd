class_name IdleState extends StateNode

@export var actor : Actor
@export var animator : AnimationPlayer
@export var animation_name : String = "idle"

@export var idle_time_min : float = 0.5
@export var idle_time_max : float = 3.0

@export var exit_state : StateNode
@export var wander_state : StateNode
@export var build_request_state : StateNode

var timer

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	timer = Timer.new()
	add_child(timer)

func _enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	animator.play(animation_name)
	actor.is_moving = false
	actor.move_direction = 0
	timer.wait_time = randf_range(idle_time_min, idle_time_max)
	timer.one_shot = true
	timer.start()

func _exit_state() -> void:
	state_exit_signal.emit()
	set_process(false)
	set_physics_process(false)
	#if exit_state:
		#state_machine.change_state(exit_state)

func _process(_delta) -> void:
	if timer.time_left <= 0:
		_exit_state()
	if actor.has_method("has_build_request"):
		if actor.has_build_request():
			exit_state = build_request_state
	pass

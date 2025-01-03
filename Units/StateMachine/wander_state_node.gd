class_name WanderState extends StateNode

@onready var timer = $Timer

@export var actor : Actor
@export var animator : AnimationPlayer
@export var animation_name : String = "wander"

@export var wander_time_min : float = 0.5
@export var wander_time_max : float = 3.0

@export var exit_state : StateNode
@export var idle_state : StateNode
@export var build_request_state : StateNode

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func _enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	animator.play(animation_name)
	actor.is_moving = true
	actor.move_direction = _get_rand_direction()
	timer.wait_time = randf_range(wander_time_min, wander_time_max)
	timer.one_shot = true
	timer.start()

func _exit_state() -> void:
	set_process(false)
	set_physics_process(false)
	state_exit_signal.emit()
	#if exit_state:
		#state_machine.change_state(exit_state)
	pass

func _process(_delta) -> void:
	if actor.has_method("has_build_request"):
		if actor.has_build_request():
			exit_state = build_request_state
		pass
	if timer.time_left <= 0:
		_exit_state()
	pass

func _physics_process(_delta: float) -> void:
	pass

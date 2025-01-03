class_name MoveToState extends StateNode

@export var actor : Actor
@export var animator : AnimationPlayer
@export var animation_name : String = "wander"

@export var exit_state : StateNode

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func _enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	animator.play(animation_name)
	actor.is_moving = false
	actor.move_direction = 0
	
	if actor is WorkerDrone:
		var building_collider = actor.build_request_target.get_node("CollisionShape2D")
		
	
func _exit_state() -> void:
	state_exit_signal.emit()
	set_process(false)
	set_physics_process(false)

func _process(_delta) -> void:
	_exit_state()
	pass

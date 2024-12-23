class_name AttackFriendlyStateNode extends StateNode

@export var actor : Actor
@export var animator : AnimationPlayer
@export var animation_name : String = "attack"

@export var exit_state : StateNode

var is_attacking: bool = false

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func _enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	animator.play(animation_name)
	actor.is_moving = false
	is_attacking = true	

func _exit_state() -> void:
	set_process(false)
	set_physics_process(false)
	state_exit_signal.emit()
	pass

func _process(_delta) -> void:
	if actor.attackTarget:
		var distance = actor.attackTarget.global_position.distance_to(actor.attackTarget.global_position)
		if distance < actor.attack_range:
			perform_attack()
	else:
		_exit_state()
		pass
	pass

func perform_attack():
	if actor.attackTarget.has_method("take_damage"):
		actor.attackTarget.take_damage(actor.attack_damage)
	await animator.animation_finished
	is_attacking = false
	_exit_state()

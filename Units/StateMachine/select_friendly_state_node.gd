class_name SelectTargetState extends StateNode

@export var actor : Actor
@export var animator : AnimationPlayer
@export var animation_name : String = "search"

@export var search_time_min : float = 0.5
@export var search_time_max : float = 2.0

@export var success_exit_state : StateNode
@export var fail_exit_state : StateNode

var exit_state : StateNode
var timer: float = 0.5

var scored_targets : Dictionary = {}


func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	timer = randf_range(search_time_min,search_time_max)

func _enter_state() -> void:
	timer = 0.5
	set_process(true)
	set_physics_process(true)
	animator.play(animation_name)
	actor.is_moving = false
	find_target()

func _exit_state() -> void:
	set_process(false)
	set_physics_process(false)
	state_exit_signal.emit()
	pass

func _process(delta) -> void:
	timer -= delta
	if timer <= 0:
		if actor.attackTarget:
			exit_state = success_exit_state
			_exit_state()
		else:
			exit_state = fail_exit_state
			_exit_state()
			
	pass

func _physics_process(_delta: float) -> void:
	pass

func find_target() -> void:
	var potential_targets : Array[Node] = get_tree().get_nodes_in_group("friendly")
	scored_targets.clear() #make sure to clean out the last check - if we're redoing
	for target in potential_targets:
		if not is_instance_valid(target):
			continue #if this is an invalid instance, skip it
		
		if target is BuildingSlotNode:
			continue #also dont select if its a building slot that hasn't been built yet
		
		var distance = actor.global_position.distance_to(target.global_position)
		var cost = target.get_target_cost() if target.has_method("get_target_cost") else 1 # defaults to 1 if not defined
		#scoring formula
		var score = (1.0 / (distance + 1)) + cost  # Closer targets and higher-cost targets score higher
		if target.is_in_group("mobile"):
			score *= 2 
			
		if not scored_targets.has(target):
			scored_targets[target] = {"score": score}
	
	if scored_targets.size() > 0:
		#sort by score
		var sorted_keys = scored_targets.keys()
		sorted_keys.sort_custom(compare_scores)
		actor.attackTarget = sorted_keys[0]


func compare_scores(a, b) -> int:
	if scored_targets[a]["score"] > scored_targets[b]["score"]:
		return 1  # a comes after b
	elif scored_targets[a]["score"] < scored_targets[b]["score"]:
		return -1  # a comes before b
	return 0  # a and b are equal

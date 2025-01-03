class_name DoWorkState extends StateNode

@export var actor : Actor
@export var animator : AnimationPlayer
@export var animation_name : String = "idle"

@export var exit_state : StateNode

func enter_state()

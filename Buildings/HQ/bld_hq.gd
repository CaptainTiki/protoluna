extends Building

@onready var rootNode = $"../../Units"


@export var drone_spawn : PackedScene = preload("res://Units/WorkerDrone/worker_drone.tscn")
var landingPadOffset : Vector2 = Vector2(192,-16)

func _init() -> void:
	display_text = "[center]HeadQuarters[/center]"
	label_offset = Vector2(-120,-240)
	bar_label = str(action_cost)
	bar_size = Vector2(100,10)
	bar_offset = Vector2(-50,-220)

func _ready() -> void:
	call_deferred("_spawn_new_player")
	pass

func on_resource_filled() -> void:
	super.on_resource_filled()
	#spawn a new worker drone
	var new_drone : WorkerDrone = drone_spawn.instantiate()
	new_drone.name = "Worker_Drone"
	new_drone.global_position = position + landingPadOffset
	rootNode.add_child(new_drone)
	pass

func _spawn_new_player()-> void:
	GameManager.spawnPlayer(position + landingPadOffset)

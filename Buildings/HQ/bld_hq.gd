extends Building

@onready var rootNode = $"../../Units"


@export var drone_spawn : PackedScene = preload("res://Units/WorkerDrone/worker_drone.tscn")
var landingPadOffset : Vector2 = Vector2(192,-16)


func _ready() -> void:
	call_deferred("_spawn_new_player")
	pass

func on_resource_filled() -> void:
	#spawn a new worker drone
	var new_drone : WorkerDrone = drone_spawn.instantiate()
	new_drone.name = "Worker_Drone"
	new_drone.global_position = position + landingPadOffset
	rootNode.add_child(new_drone)
	pass

func _spawn_new_player()-> void:
	GameManager.spawnPlayer(position + landingPadOffset)

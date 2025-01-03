class_name Game_Manager extends Node

@warning_ignore("unused_signal")
signal building_request(building: Building)

var debug_node_scene : PackedScene = preload("res://Managers/debug_node.tscn")
var playerDronescene : PackedScene = preload("res://Units/PlayerDrone/player_drone.tscn")

var debug_node : Debug_Node
var player : Player_Drone

var interaction_speed : float = 1.5

var worker_drones : Array[Actor] = [] #to keep track of our drones
var worker_requests : Array[Building] = [] #queue to keep track of build / repairs

# Called when the node enters the scene tree for the first time.
func _ready():
	debug_node = debug_node_scene.instantiate()
	debug_node.name = "Debug Node"
	add_child(debug_node)
	pass # Replace with function body.

func get_player() -> Node:
	return player

func get_player_position() -> Vector2:
	if player:
		return player.global_position
	else:
		return Vector2(0,624) #if no player, return origin

func spawnPlayer(pos: Vector2 = Vector2(192,624)) -> void:
	player = playerDronescene.instantiate()
	var node = get_node("../LevelRoot/Units")
	node.add_child(player)
	player.position = pos
	pass

func add_debug_info(key: String, value: String) -> void:
	debug_node.add_debug_info(key, value)

func remove_debug_info(key: String) -> void:
	debug_node.remove_debug_info(key)

func update_debug_time(is_daytime: bool, time: String) -> void:
	debug_node.update_time(is_daytime, time)
func _on_timer_timeout() -> void:
	pass # Replace with function body.

func add_worker(worker : Actor) -> void:
	worker_drones.append(worker) #add new drone to list of drones
	pass

func notify_building_request(building: Building) -> void:
	worker_requests.append(building)
	emit_signal("building_request", building)
	pass

class_name Game_Manager extends Node

var debug_node_scene : PackedScene = preload("res://Managers/debug_node.tscn")
var playerDronescene : PackedScene = preload("res://Units/PlayerDrone/player_drone.tscn")

var debug_node : Debug_Node
var player : Player_Drone

var interaction_speed : float = 1.5

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
	self.get_parent().add_child(player)
	player.position = pos
	pass

func add_debug_info(key: String, value: String) -> void:
	debug_node.add_debug_info(key, value)

func remove_debug_info(key: String) -> void:
	debug_node.remove_debug_info(key)

class_name Game_Manager extends Node

var playerDronescene : PackedScene = preload("res://Units/player_drone.tscn")
var player : Player_Drone

var interaction_speed : float = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	
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

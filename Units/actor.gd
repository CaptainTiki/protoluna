class_name Actor extends CharacterBody2D

@onready var sprite = $Sprite

@export var max_speed : float = 200.0
@export var acceleration : float = 75

@export var health : float = 10

@export var attack_range: float = 10.0
@export var attack_damage: int = 10

@export var actor_cost : float = 5.0 #how high of a priorty target are we for the AI

var move_direction : float = 0
var is_moving = false

var attackTarget : Node2D

func _init() -> void:
	add_to_group("mobile")

func _flip_all_sprites(flipped : bool) -> void:
	for child in sprite.get_children():
		if child is Sprite2D:
			child.flip_h = flipped

func get_target_cost() -> float:
	return actor_cost

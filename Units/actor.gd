class_name Actor extends CharacterBody2D

@onready var sprite_2d = $Sprite

@export var max_speed : float = 200.0
@export var acceleration : float = 75

var move_direction : float = 0
var is_moving = false


func _flip_all_sprites(flipped : bool) -> void:
	for child in sprite_2d.get_children():
		if child is Sprite2D:
			child.flip_h = flipped

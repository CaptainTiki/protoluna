class_name Actor extends CharacterBody2D

@onready var sprite_2d = $Sprite2D

@export var max_speed : float = 50.0
@export var acceleration : float = 10.0

var facing_direction : int = 1

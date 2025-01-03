class_name HitBoxComponent extends Area2D

#this class is what you use to 'get hit' with - a HURT box is what you use to hurt people with

@export var health_component : HealthComponent

@warning_ignore("unused_signal")
signal hitbox_hit

func take_damage(dmg : int) -> void:
	health_component.take_damage(dmg)
	pass

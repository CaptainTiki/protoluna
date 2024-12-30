class_name HealthComponent extends Node

@export var max_health_points : int = 1
@export var low_health_percent : float = 0.25 

signal health_full
signal health_low
signal health_zero

var current_health_points

func take_damage(dmg : int) -> void:
	current_health_points -= dmg
	if current_health_points < max_health_points * low_health_percent:
		health_low.emit()
	if current_health_points < 0:
		current_health_points = 0
		health_zero.emit()
	pass

func restore_health(ammount : int) -> void:
	current_health_points += ammount
	if current_health_points > max_health_points:
		current_health_points = max_health_points
		health_full.emit()
	pass

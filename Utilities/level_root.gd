extends Node2D

var test = preload("res://Units/Enemies/Crawler/crawler_enemy.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_click"):
		var newtest : Node2D = test.instantiate()
		newtest.global_position = Vector2(0,400)
		add_child(newtest)

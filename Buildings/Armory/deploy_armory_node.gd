extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rootNode = $"../../Buildings"
@export var deploy_scene: PackedScene #scene to deploy

var current_stage = 0

func _ready() -> void:
	animation_player.play("Deploy")
	pass

func _process(delta: float) -> void:
	if animation_player.is_playing() == false:
		finish_deployment()
	pass

func finish_deployment() -> void:
	if deploy_scene:
		var building : Node2D = deploy_scene.instantiate()
		building.name = "Armory"
		rootNode.add_child(building)
		building.position = self.position
	queue_free()
	pass

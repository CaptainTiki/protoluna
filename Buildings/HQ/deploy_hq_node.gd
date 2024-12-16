extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

@export var deploy_scene: PackedScene #scene to deploy once landed 

var animations : Array[String] = ["HQSkirtDeploy","HQRightBLDDeploy","HQLeftBldDeploy","HQTowerDeploy","HQGadgetsDeploy","HQPadDeploy"]
var current_stage = 0

func _ready() -> void:
	play_next_animation()
	pass

func play_next_animation() -> void:
	if current_stage < animations.size(): #keep from overflow
		animation_player.play(animations[current_stage])
		current_stage += 1
	else:
		finish_deployment()
		pass

func finish_deployment() -> void:
	if animation_player.is_playing() == false:
		if deploy_scene:
			var building : Node2D = deploy_scene.instantiate()
			building.name = "HQ_Building"
			get_parent().add_child(building)
			building.position = self.position
		queue_free()
	pass

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	timer.start(0.25) #wait time until starting a new animation - so it doesn't just flow 1 to another

func _on_timer_timeout() -> void:
	play_next_animation()
